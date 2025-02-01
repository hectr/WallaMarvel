import SwiftSyntax
import SwiftSyntaxMacros

/// A macro to validate `@Action` functions.
public struct ActionMacro: PeerMacro
{
    public static func expansion<Decl: DeclSyntaxProtocol>(
        of node: AttributeSyntax,
        providingPeersOf decl: Decl,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax]
    {
        // 1) Ensure declaration is a function
        guard let funcDecl = decl.as(FunctionDeclSyntax.self) else {
            throw MacroExpansionError("@Action can only be applied to functions")
        }

        // 2) Ensure the method is static
        let isStatic = funcDecl.modifiers.contains { $0.name.tokenKind == .keyword(.static) }
        if !isStatic {
            throw MacroExpansionError("@Action functions must be static")
        }

        // 3) Gather all `inout` parameters
        let inoutParams = funcDecl.signature.parameterClause.parameters.filter { param in
            param.type.description.contains("inout")
        }

        // 3) Check there is at least one `inout` parameter
        if inoutParams.isEmpty {
            throw MacroExpansionError("@Action function must have an 'inout state' parameter")
        }

        // 4) Check there is only one `inout` parameter
        if inoutParams.count > 1 {
            throw MacroExpansionError("@Action function must have only one 'inout' parameter")
        }

        return [] // No transformations are performed by this macro
    }
}
