
public struct CharacterModelContainer: Codable, Sendable
{
    public let count: Int
    public let limit: Int
    public let offset: Int
    public let results: [CharacterModel]

    public init(
        count: Int,
        limit: Int,
        offset: Int,
        results: [CharacterModel]
    )
    {
        self.count = count
        self.limit = limit
        self.offset = offset
        self.results = results
    }
}
