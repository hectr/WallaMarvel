@testable import Networking
@testable import NetworkingTestSupport
import Testing
import Foundation

@Suite
struct URLRequestTests
{

    @Test("When initializing URLRequest from an endpoint, it correctly sets the URL and method")
    func testURLRequestFromEndpoint() throws
    {
        // Given
        let endpoint = EndpointMock()
        endpoint.baseUrl = "http://example.org"
        endpoint.path = "/test"
        endpoint.method = .custom("POST")
        endpoint.query = ["key": "value"]

        // When
        let request = try URLRequest(endpoint)
        
        // Then
        #expect(request.url?.absoluteString == "http://example.org/test?key=value")
        #expect(request.httpMethod == "POST")
    }
}
