import Foundation
import Networking

protocol MakeCharactersEndpointProtocol
{
    func callAsFunction(
        limit: Int?,
        nameStartsWith: String?,
        offset: Int?
    ) -> Endpoint
}

struct MakeCharactersEndpoint: MakeCharactersEndpointProtocol
{
    enum Constant
    {
        static let privateKey = "188f9a5aa76846d907c41cbea6506e4cc455293f"
        static let publicKey = "d575c26d5c746f623518e753921ac847"
    }

    // MARK: Lifecycle

    static func make() -> MakeCharactersEndpointProtocol
    {
        MakeCharactersEndpoint()
    }

    init()
    {}

    // MARK: Logic

    public func callAsFunction(
        limit: Int?,
        nameStartsWith: String?,
        offset: Int?
    ) -> Endpoint
    {
        let timestamp = Int(Date().timeIntervalSince1970)
        let privateKey = Constant.privateKey
        let publicKey = Constant.publicKey
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5
        let nonEmptyNameStartsWith = nameStartsWith?.isEmpty == true
        ? nil
        : nameStartsWith
        return CharactersEndpoint(
            hash: hash,
            limit: limit,
            nameStartsWith: nonEmptyNameStartsWith,
            offset: offset,
            publicKey: publicKey,
            timestamp: timestamp
        )
    }
}
