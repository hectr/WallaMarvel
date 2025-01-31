public struct CharacterDataModel: Codable, Hashable, Identifiable, Sendable
{
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: Thumbnail
}
