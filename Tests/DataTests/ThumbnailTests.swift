@testable import DataContracts
import Testing
import Foundation

@Suite
struct ThumbnailTests
{
    @Test("CharacterDataModel can be encoded and decoded correctly")
    func json() throws
    {
        // Given
        let json = """
        {
          "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
          "extension": "jpg"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        // When
        let decoded = try decoder.decode(Thumbnail.self, from: json)
        let encoded = try encoder.encode(decoded)
        let redecoded = try decoder.decode(Thumbnail.self, from: encoded)

        // Then
        #expect(decoded.path == "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784")
        #expect(decoded.extension == "jpg")
        #expect(redecoded == decoded)
    }
}
