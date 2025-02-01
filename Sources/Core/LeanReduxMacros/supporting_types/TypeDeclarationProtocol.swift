import SwiftSyntax

protocol TypeDeclarationProtocol
{
    var memberBlock: MemberBlockSyntax { get }
}

extension EnumDeclSyntax: TypeDeclarationProtocol
{}

extension StructDeclSyntax: TypeDeclarationProtocol
{}

extension ActorDeclSyntax: TypeDeclarationProtocol
{}

extension ClassDeclSyntax: TypeDeclarationProtocol
{}

extension ProtocolDeclSyntax: TypeDeclarationProtocol
{}
