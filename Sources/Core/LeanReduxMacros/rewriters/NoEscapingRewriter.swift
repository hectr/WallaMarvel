import SwiftSyntax

/// A rewriter that removes `@escaping` tokens from a type syntax node.
class NoEscapingRewriter: SyntaxRewriter
{
    override func visit(_ token: TokenSyntax) -> TokenSyntax
    {
        // If the token's text is "@escaping", return an empty token
        if token.tokenKind == .atSign, token.nextToken(viewMode: .fixedUp)?.tokenKind == .identifier("escaping") {
            return .unknown("")
        } else if token.tokenKind == .identifier("escaping"), token.previousToken(viewMode: .fixedUp)?.tokenKind == .atSign {
            return .unknown("")
        }
        return token
    }
}

extension TypeSyntax
{
    func withoutEscaping() -> TypeSyntax
    {
        let rewriter = NoEscapingRewriter()
        let result = rewriter.rewrite(self._syntaxNode)
        // Convert back to TypeSyntax
        return result.as(TypeSyntax.self) ?? self
    }
}
