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
          "id": 1011334,
          "name": "3-D Man",
          "description": "",
          "thumbnail": {
            "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
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
        #expect(decoded.id == 1011334)
        #expect(decoded.name == "3-D Man")
        #expect(decoded.thumbnail.path == "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784")
        #expect(decoded.thumbnail.extension == "jpg")
        #expect(redecoded == decoded)
    }
}
