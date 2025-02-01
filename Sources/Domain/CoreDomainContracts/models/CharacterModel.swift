import Foundation

public struct CharacterModel: Codable, Hashable, Identifiable, Sendable
{
    public let id: Int
    public let name: String
    public let heroDescription: String
    public let thumbnail: URL?

    public init(
        id: ID,
        name: String,
        heroDescription: String,
        thumbnail: URL?
    )
    {
        self.id = id
        self.name = name
        self.heroDescription = heroDescription
        self.thumbnail = thumbnail
    }
}
