public struct CharacterDataModel: Codable, Identifiable, Sendable
{
    public let id: Int
    public let name: String
    public let thumbnail: Thumbnail
}
