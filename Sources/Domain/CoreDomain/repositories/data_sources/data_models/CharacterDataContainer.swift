
struct CharacterDataContainer: Codable, Hashable, Sendable
{
    struct CharacterData: Codable, Hashable, Sendable {
        let count: Int
        let limit: Int
        let offset: Int
        let results: [CharacterDataModel]
    }

    let data: CharacterData
}
