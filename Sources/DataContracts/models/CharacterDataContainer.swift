public struct CharacterDataContainer: Codable, Hashable, Sendable
{
    public struct CharacterData: Codable, Hashable, Sendable {
        public let count: Int
        public let limit: Int
        public let offset: Int
        public let results: [CharacterDataModel]
    }

    public let data: CharacterData
}
