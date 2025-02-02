@testable import Networking
@testable import NetworkingTestSupport
import Collections
import Testing
import Foundation

@Suite
struct URLBuilderTests
{
    @Test("When initialized with a valid URL, it does not throw errors")
    func testInitWithBaseUrl() throws
    {
        let baseUrl = "http://example.org"
        #expect(try URLBuilder(baseUrl: baseUrl).build().absoluteString == baseUrl)
    }

    @Test("When initialized with an invalid URL, it throws an error")
    func testInitWithEmptyBaseUrl()
    {
        do {
            _ = try URLBuilder(baseUrl: "")
            Issue.record("Expected to throw an error when initializing with an empty URL")
        } catch {
            if case Failure.invalidUrl(let url) = error {
                #expect(url == "")
            } else {
                Issue.record("Expected to catch a Failure.invalidUrl")
            }
        }
    }

    @Test("When adding paths, they are correctly appended to the base URL")
    func testAddPath() throws
    {
        // Given
        let sut = try URLBuilder(baseUrl: "http://example.org")

        // When
        try sut.add(path: "path")
        try sut.add(path: "component")

        // Then
        #expect(try sut.build().absoluteString == "http://example.org/path/component")
    }

    @Test("When adding parameters, they are correctly added to the URL")
    func testAddParameters() throws
    {
        // Given
        let sut = try! URLBuilder(baseUrl: "http://example.org")

        // When
        sut.add(parameters: ["param": "0"])

        // Then
        #expect(try sut.build().absoluteString.contains("param=0"))
    }

    @Test("When adding duplicate parameters without replacing, they appear multiple times in the URL")
    func testAddParametersWithoutReplacingDuplicates() throws
    {
        // Given
        let sut = try URLBuilder(baseUrl: "http://example.org")
        let someParameter: OrderedDictionary<String, CustomStringConvertible?> = ["param": 0]

        // When
        sut.add(parameters: someParameter)
        sut.add(parameters: someParameter)

        // Then
        #expect(try sut.build().absoluteString == "http://example.org?param=0&param=0")
    }

    @Test("When encoding parameters, special characters are correctly percent-encoded")
    func testUrlEncodingOfParameters() throws
    {
        // Given
        let sut = try URLBuilder(baseUrl: "http://example.org")
        try sut.add(path: "path")

        // When
        sut.add(parameters: ["param": "some \"parámetro\""])

        // Then
        #expect(try sut.build().absoluteString == "http://example.org/path?param=some%20%22par%C3%A1metro%22")
    }

    @Test("When adding empty or nil parameters, the URL remains unchanged or appends only the question mark")
    func testParametersQuestionMark()
    {
        // Given
        let sut = try! URLBuilder(baseUrl: "http://example.org")

        // When
        sut.add(parameters: nil)
        let result1 = try? sut.build().absoluteString
        sut.add(parameters: [:])
        let result2 = try? sut.build().absoluteString

        // Then
        #expect(result1 == "http://example.org")
        #expect(result2 == "http://example.org?")
    }
}
