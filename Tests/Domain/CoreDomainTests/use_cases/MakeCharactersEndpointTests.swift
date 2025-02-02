@testable import CoreDomain
import Foundation
@testable import Networking
import Testing

@Suite
struct MakeCharactersEndpointTests
{
    @Test("When calling MakeCharactersEndpoint, it generates an endpoint with the correct parameters")
    func testMakeCharactersEndpoint()
    {
        // Given
        let factory = MakeCharactersEndpoint()
        let limit = 10
        let nameStartsWith = "Spider"
        let offset = 5

        // When
        let endpoint = factory(limit: limit, nameStartsWith: nameStartsWith, offset: offset)

        // Then
        #expect(endpoint is CharactersEndpoint)
        if let charactersEndpoint = endpoint as? CharactersEndpoint {
            #expect(charactersEndpoint.limit == limit)
            #expect(charactersEndpoint.nameStartsWith == nameStartsWith)
            #expect(charactersEndpoint.offset == offset)
            #expect(charactersEndpoint.publicKey == MakeCharactersEndpoint.Constant.publicKey)
            #expect(!charactersEndpoint.hash.isEmpty)
        }
    }

    @Test("When nameStartsWith is an empty string, it should not be included in the query")
    func testEmptyNameStartsWith()
    {
        // Given
        let factory = MakeCharactersEndpoint()
        let limit = 10
        let nameStartsWith = ""
        let offset = 5

        // When
        let endpoint = factory(limit: limit, nameStartsWith: nameStartsWith, offset: offset)

        // Then
        if let charactersEndpoint = endpoint as? CharactersEndpoint {
            #expect(charactersEndpoint.nameStartsWith == nil)
        } else {
            Issue.record("Expected CharactersEndpoint type")
        }
    }

    @Test("When calling MakeCharactersEndpoint, it correctly generates a hash")
    func testGeneratedHash()
    {
        // Given
        let factory = MakeCharactersEndpoint()

        // When
        let endpoint = factory(limit: nil, nameStartsWith: nil, offset: nil)

        // Then
        if let charactersEndpoint = endpoint as? CharactersEndpoint {
            #expect(!charactersEndpoint.hash.isEmpty)
        } else {
            Issue.record("Expected CharactersEndpoint type")
        }
    }
}
