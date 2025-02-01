import SwiftSyntax

/// Finds a method in the given declaration.
/// - Parameters:
///   - static: Whether the method is static or not.
///   - attribute: The attribute the method must have (without the '@'). If nil, any attribute is accepted.
///   - declaration: The declaration where to find the method.
/// - Returns: The method declaration.
/// 
func findMethods(
    static: Bool,
    attribute: String? = nil,
    in declaration: TypeDeclarationProtocol
) -> [FunctionDeclSyntax]
{
    declaration
        .memberBlock
        .members
        .compactMap { member -> FunctionDeclSyntax? in
            // Must be a function
            guard let functionDeclaration = member.decl.as(FunctionDeclSyntax.self) else {
                return nil
            }

            // Must be static or not
            let isStatic = functionDeclaration.modifiers.contains { modifier in
                modifier.name.tokenKind == .keyword(.static)
            }
            guard isStatic == `static` else {
                return nil
            }

            // Must have the given attribute
            let hasAttribute = attribute == nil || functionDeclaration
                .attributes
                .contains { attr in
                    if case let .`attribute`(attributeSyntax) = attr {
                        return attribute == attributeSyntax.attributeName.as(IdentifierTypeSyntax.self)?.name.text
                    } else {
                        return false
                    }
                }
            guard hasAttribute else {
                return nil
            }
            
            return functionDeclaration
        }
}
