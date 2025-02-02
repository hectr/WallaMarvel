import Collections
@testable import CoreDomain
@testable import Networking
import Testing

@Suite
struct CharactersEndpointTests
{
    @Test("CharactersEndpoint has the expected baseUrl")
    func testBaseUrl()
    {
        // Given
        let endpoint = CharactersEndpoint(
            hash: "testhash",
            publicKey: "testPublicKey",
            timestamp: 12345
        )

        // Then
        #expect(endpoint.baseUrl == "https://gateway.marvel.com:443")
    }

    @Test("CharactersEndpoint has the expected path")
    func testPath()
    {
        // Given
        let endpoint = CharactersEndpoint(
            hash: "testhash",
            publicKey: "testPublicKey",
            timestamp: 12345
        )

        // Then
        #expect(endpoint.path == "v1/public/characters")
    }

    @Test("CharactersEndpoint has the expected HTTP method")
    func testMethod()
    {
        // Given
        let endpoint = CharactersEndpoint(
            hash: "testhash",
            publicKey: "testPublicKey",
            timestamp: 12345
        )

        // Then
        #expect(endpoint.method == .get)
    }

    @Test("CharactersEndpoint constructs the expected query parameters")
    func testQueryParameters()
    {
        // Given
        let endpoint = CharactersEndpoint(
            hash: "testhash",
            limit: 10,
            nameStartsWith: "Spider",
            offset: 5,
            publicKey: "testPublicKey",
            timestamp: 12345
        )

        // Then
        #expect(endpoint.query.count == 6)
        #expect(endpoint.query["apikey"] as? String == "testPublicKey")
        #expect(endpoint.query["hash"] as? String == "testhash")
        #expect(endpoint.query["limit"] as? Int == 10)
        #expect(endpoint.query["offset"] as? Int == 5)
        #expect(endpoint.query["nameStartsWith"] as? String == "Spider")
        #expect(endpoint.query["ts"] as? Int == 12345)
    }
}
