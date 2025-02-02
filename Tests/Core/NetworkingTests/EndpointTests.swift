@testable import Networking
import Testing
import Collections
import Foundation

@Suite
struct EndpointDefaultsTests
{
    private struct TestEndpoint: Endpoint
    {
        let baseUrl: String = "http://example.org"
        let path: String = "/test"
        let query: OrderedDictionary<String, CustomStringConvertible?> = [:]
    }

    @Test("Default HTTP method is GET")
    func testDefaultHTTPMethod()
    {
        // Given
        let endpoint = TestEndpoint()

        // Then
        #expect(endpoint.method == .get)
    }

    @Test("Default response deserializer is JSONDeserializer")
    func testDefaultResponseDeserializer()
    {
        // Given
        let endpoint = TestEndpoint()

        // Then
        #expect(endpoint.responseDeserializer is JSONDeserializer)
    }
}
