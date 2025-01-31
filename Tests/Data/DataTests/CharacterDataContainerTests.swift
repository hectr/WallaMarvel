@testable import DataContracts
import Testing
import Foundation

@Suite
struct CharacterDataContainerTests
{
    @Test("CharacterDataContainer can be encoded and decoded correctly")
    func json() throws
    {
        // Given
        let json = """
        {
          "data": {
            "offset": 0,
            "limit": 20,
            "total": 1564,
            "count": 20,
            "results": [
              {
                "id": 1011334,
                "name": "3-D Man",
                "description": "",
                "thumbnail": {
                  "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                  "extension": "jpg"
                }
              }
            ]
          }
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let encoder = JSONEncoder()

        // When
        let decoded = try decoder.decode(CharacterDataContainer.self, from: json)
        let encoded = try encoder.encode(decoded)
        let redecoded = try decoder.decode(CharacterDataContainer.self, from: encoded)

        // Then
        #expect(decoded.data.count == 20)
        #expect(decoded.data.limit == 20)
        #expect(decoded.data.offset == 0)
        #expect(decoded.data.results.count == 1)
        #expect(decoded.data.results.first?.id == 1011334)
        #expect(decoded.data.results.first?.name == "3-D Man")
        #expect(decoded.data.results.first?.thumbnail.path == "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784")
        #expect(decoded.data.results.first?.thumbnail.extension == "jpg")
        #expect(redecoded == decoded)
    }
}
