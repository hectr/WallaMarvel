@testable import Networking
@testable import NetworkingTestSupport
import Testing
import Foundation

@Suite
struct URLTests
{

    @Test("When initializing URL with a valid endpoint, it constructs the correct URL")
    func testURLFromEndpoint() throws
    {
        // Given
        let endpoint = EndpointMock()
        endpoint.baseUrl = "http://example.org"
        endpoint.path = "/test"
        endpoint.query = ["key": "value"]
        
        // When
        let url = try URL(endpoint)
        
        // Then
        #expect(url.absoluteString == "http://example.org/test?key=value")
    }
    
    @Test("When initializing URL with a valid string, it succeeds")
    func testURLFromString() throws
    {
        // Given
        let urlString = "http://example.org"
        
        // When
        let url = try URL(urlString)
        
        // Then
        #expect(url.absoluteString == urlString)
    }
    
    @Test("When initializing URL with an invalid string, it throws an invalidUrl error")
    func testURLFromInvalidString()
    {
        do {
            _ = try URL("")
            Issue.record("Expected to throw an error when initializing with an empty URL")
        } catch {
            if case Failure.invalidUrl(let url) = error {
                #expect(url == "")
            } else {
                Issue.record("Expected to catch a Failure.invalidUrl")
            }
        }
    }

    @Test("When initializing URL with valid URLComponents, it constructs the correct URL")
    func testURLFromComponents() throws
    {
        // Given
        var components = URLComponents()
        components.scheme = "http"
        components.host = "example.org"
        
        // When
        let url = try URL(components)
        
        // Then
        #expect(url.absoluteString == "http://example.org")
    }
}
