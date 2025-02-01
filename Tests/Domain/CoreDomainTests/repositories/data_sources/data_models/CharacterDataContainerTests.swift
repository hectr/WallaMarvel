@testable import CoreDomain
import Foundation
import Testing

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
                "id": 1017100,
                "name": "A-Bomb (HAS)",
                "description": "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ",
                "modified": "2013-09-18T15:54:04-0400",
                "thumbnail": {
                  "path": "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
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
        #expect(decoded.data.results.first?.id == 1017100)
        #expect(decoded.data.results.first?.name == "A-Bomb (HAS)")
        #expect(decoded.data.results.first?.description.hasPrefix("Rick Jones") == true)
        #expect(decoded.data.results.first?.thumbnail.path == "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16")
        #expect(decoded.data.results.first?.thumbnail.extension == "jpg")
        #expect(redecoded == decoded)
    }
}
