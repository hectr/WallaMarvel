import Foundation

public struct CharacterDataModel: Decodable, Sendable {
    public let id: Int
    public let name: String
    public let thumbnail: Thumbnail
}
