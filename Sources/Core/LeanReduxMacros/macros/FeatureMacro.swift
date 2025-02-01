import SwiftSyntax
import SwiftSyntaxMacros

/// A macro to generate LeanRedux features boilerplate code.
/// It generates the `Store` typealias, the `Action` enum, and the `reduce` function.
public struct FeatureMacro: MemberMacro
{
    public static func expansion<Decl: DeclSyntaxProtocol>(
        of node: AttributeSyntax,
        providingMembersOf declaration: Decl,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax]
    {
        // 1) Ensure it's a valid declaration
        guard let declaration: TypeDeclarationProtocol
                = declaration.as(ActorDeclSyntax.self)
                ?? declaration.as(ClassDeclSyntax.self)
                ?? declaration.as(EnumDeclSyntax.self)
                ?? declaration.as(StructDeclSyntax.self)
        else {
            throw MacroExpansionError("@Feature can only be applied to actors, classes, enums and structs")
        }

        // 2) Gather all @Action static functions
        let actionMethods = findMethods(static: true, attribute: "Action", in: declaration)

        // 3) For each action method, parse its name & parameters into an enum case
        let actionCases = actionMethods.map(convertFunctionToEnumCase(functionDeclaration:))

        // 4) Build the `Action` enum with DTO conformance
        let actionEnum = EnumDeclSyntax(
            name: "Action",
            inheritanceClause: InheritanceClauseSyntax(
                inheritedTypes: InheritedTypeListSyntax([
                    InheritedTypeSyntax(type: IdentifierTypeSyntax(name: .identifier("DTO"))),
                ])),
            memberBlock: MemberBlockSyntax {
                MemberBlockItemListSyntax {
                    for action in actionCases {
                        MemberBlockItemSyntax(
                            decl: EnumCaseDeclSyntax {
                                EnumCaseElementListSyntax { action }
                            }
                        )
                    }
                }
            }
        )

        // 5) Build `typealias Store`
        let storeTypealias = makeTypeAlias(name: "Store", value: "LeanRedux.Store<Action, State>")

        // 6) Build `reduce(...)` function
        let reduceFuncBody = makeReduceFuncBody(actionMethods: actionMethods)

        let reduceFunc = FunctionDeclSyntax(
            modifiers: DeclModifierListSyntax(itemsBuilder: {
                DeclModifierSyntax(name: .keyword(.static))
            }),
            name: .identifier("reduce"),
            signature: FunctionSignatureSyntax( // signature: (currentState: State, receivedAction: Action) -> State
                parameterClause: FunctionParameterClauseSyntax(
                    parameters: FunctionParameterListSyntax([
                        FunctionParameterSyntax(
                            firstName: .identifier("currentState"),
                            colon: .colonToken(),   // for “currentState:”
                            type: IdentifierTypeSyntax(name: .identifier("State")),
                            trailingComma: .commaToken()
                        ),
                        FunctionParameterSyntax(
                            firstName: .identifier("receivedAction"),
                            colon: .colonToken(),
                            type: IdentifierTypeSyntax(name: .identifier("Action"))
                        )
                    ])
                ),
                returnClause: ReturnClauseSyntax(type: IdentifierTypeSyntax(name: .identifier("State")))
                                              ),
            body: reduceFuncBody
        )

        // Return both the enum and the reduce function
        return [DeclSyntax(actionEnum), DeclSyntax(storeTypealias), DeclSyntax(reduceFunc)]
    }

    // MARK: - Helpers to build reduce function

    private static func makeReduceFuncBody(actionMethods: [FunctionDeclSyntax]) -> CodeBlockSyntax
    {
        // Store each top-level statement in an array of `CodeBlockItemSyntax`.
        var methodStatements = [CodeBlockItemSyntax]()

        // 1) var newState = currentState
        let varNewState = CodeBlockItemSyntax(item: .expr(
            ExprSyntax(
                SequenceExprSyntax(elements: ExprListSyntax([
                    // "var"
                    DeclReferenceExprSyntax(baseName: .identifier("var")),
                    // "newState"
                    DeclReferenceExprSyntax(baseName: .identifier("newState")),
                    // "="
                    BinaryOperatorExprSyntax(operator: .equalToken()),
                    // "currentState"
                    DeclReferenceExprSyntax(baseName: .identifier("currentState"))
                ]))
            )
        ))
        methodStatements.append(varNewState)

        // 2) switch receivedAction { ... }
        // Build a `SwitchExprSyntax`:
        let switchExpr = SwitchExprSyntax(
            switchKeyword: .keyword(.switch),
            subject: ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier("receivedAction"))),
            leftBrace: .leftBraceToken(),
            cases: makeSwitchCaseListSyntax(actionMethods: actionMethods),
            rightBrace: .rightBraceToken()
        )

        // Insert the switch as a statement: `switch receivedAction { ... }`
        methodStatements.append(
            CodeBlockItemSyntax(item: .expr(ExprSyntax(switchExpr)))
        )

        // 3) return newState
        let returnStmt = CodeBlockItemSyntax(
            item: .stmt(StmtSyntax(
                ReturnStmtSyntax(expression: ExprSyntax(
                    DeclReferenceExprSyntax(baseName: .identifier("newState"))
                ))
            ))
        )
        methodStatements.append(returnStmt)

        return CodeBlockSyntax(statements: CodeBlockItemListSyntax(methodStatements))
    }

    /// Produces `case .foo(let a, let b):`.
    private static func makeSwitchCaseListSyntax(actionMethods: [FunctionDeclSyntax]) -> SwitchCaseListSyntax
    {
        SwitchCaseListSyntax(
            actionMethods.compactMap { functionDecl -> SwitchCaseListSyntax.Element? in
                let funcName = functionDecl.name.text

                // Gather names of non-inout params, e.g. ["a", "b"]
                let params = functionDecl.signature.parameterClause.parameters.compactMap { param -> String? in
                    let typeDesc = param.type.description
                    if typeDesc.contains("inout") {
                        return nil // skip inout
                    }
                    return param.firstName.text
                }

                // e.g. "let a, let b"
                let joinedValues = params.map { "let \($0)" }.joined(separator: ", ")
                // e.g. "(let a, let b)"
                let associatedValues = "\(params.count > 0 ? "(" : "")\(joinedValues)\(params.count > 0 ? ")" : "")"
                // e.g. a: a, b: b
                let joinedParams = params.map { "\($0): \($0)" }.joined(separator: ", ")
                // e.g. (a: a, b: b, state: &newState)
                let functionParams = params.isEmpty ? "(state: &newState)" : "(\(joinedParams), state: &newState)"
                // e.g. case .foo(let a, let b): foo(a: a, b: b, state: &newState)
                let snippet = "case .\(funcName)\(associatedValues): \(funcName)\(functionParams)"

                let caseSyntax = SwitchCaseSyntax(stringLiteral: snippet)
                return .switchCase(caseSyntax)
            }
        )
    }
}
