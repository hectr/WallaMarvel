
struct CharacterDataModel: Codable, Hashable, Identifiable, Sendable
{
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}
