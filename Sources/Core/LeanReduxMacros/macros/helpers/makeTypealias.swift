import SwiftSyntax

/// Creates a type alias declaration node.
/// - Parameters:
///   - name: The name of the type alias. It also accepts a string.
///   - value: The identifier of the type alias. It also accepts a string.
/// - Returns: A type alias declaration node.
/// 
func makeTypeAlias(name: TokenSyntax, value: TokenSyntax) -> TypeAliasDeclSyntax
{
    TypeAliasDeclSyntax(
        name: name,
        initializer: TypeInitializerClauseSyntax(
            value: IdentifierTypeSyntax(name: value)
        )
    )
}
