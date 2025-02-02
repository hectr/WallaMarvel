import Foundation
@testable import Networking
@testable import NetworkingTestSupport
import Testing

@Suite
struct HTTPMethodTests
{

    @Test("When accessing the verb property, it returns the correct string value")
    func testVerbProperty()
    {
        // Given
        let getMethod = HTTPMethod.get
        let customMethod = HTTPMethod.custom("POST")

        // When
        let getVerb = getMethod.verb
        let customVerb = customMethod.verb

        // Then
        #expect(getVerb == "GET")
        #expect(customVerb == "POST")
    }

    @Test("When comparing two HTTPMethod values, equality is determined by the verb string")
    func testEquatableConformance()
    {
        // Given
        let method1 = HTTPMethod.get
        let method2 = HTTPMethod.custom("GET")
        let method3 = HTTPMethod.custom("DELETE")

        // Then
        #expect(method1 == method2)
        #expect(method1 != method3)
    }
}
