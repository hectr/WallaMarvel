@testable import DataContracts
import Testing
import Foundation

@Suite
struct CharacterDataModelTests
{
    @Test("CharacterDataModel can be encoded and decoded correctly")
    func json() throws
    {
        // Given
        let json = """
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
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        // When
        let decoded = try decoder.decode(CharacterDataModel.self, from: json)
        let encoded = try encoder.encode(decoded)
        let redecoded = try decoder.decode(CharacterDataModel.self, from: encoded)
        
        // Then
        #expect(decoded.id == 1017100)
        #expect(decoded.name == "A-Bomb (HAS)")
        #expect(decoded.description.hasPrefix("Rick Jones"))
        #expect(decoded.thumbnail.path == "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16")
        #expect(decoded.thumbnail.extension == "jpg")
        #expect(redecoded == decoded)
    }
}
