@testable import Networking
@testable import NetworkingTestSupport
import Testing
import Foundation

@Suite
struct URLComponentsTests
{
    @Test("When initializing URLComponents from a valid URL, it succeeds")
    func testURLComponentsFromURL() throws
    {
        // Given
        let url = URL(string: "http://example.org")!
        
        // When
        let components = try URLComponents(url)
        
        // Then
        #expect(components.host == "example.org")
    }
}
