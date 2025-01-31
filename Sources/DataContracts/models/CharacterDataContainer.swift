public struct CharacterDataContainer: Codable, Sendable
{
    public struct CharacterData: Codable, Sendable {
        public let count: Int
        public let limit: Int
        public let offset: Int
        public let results: [CharacterDataModel]
    }

    public let data: CharacterData
}
