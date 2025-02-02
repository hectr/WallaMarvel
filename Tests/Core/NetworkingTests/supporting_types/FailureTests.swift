import Foundation
@testable import Networking
import Testing

@Suite
struct FailureTests
{
    @Test("When initialized with a DecodingError, it correctly maps to the decodingError case")
    func testDecodingErrorMapping()
    {
        // Given
        let decodingError = DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Test decoding error"))

        // When
        let failure = Failure(decodingError)

        // Then
        if case .decodingError(let error) = failure {
            #expect((error as NSError) == (decodingError as NSError))
        } else {
            Issue.record("Expected Failure.decodingError but got \(failure)")
        }
    }

    @Test("When initialized with a URLError, it correctly maps to the urlError case")
    func testURLErrorMapping()
    {
        // Given
        let urlError = URLError(.notConnectedToInternet)

        // When
        let failure = Failure(urlError)

        // Then
        if case .urlError(let error) = failure {
            #expect(error.code == .notConnectedToInternet)
        } else {
            Issue.record("Expected Failure.urlError but got \(failure)")
        }
    }

    @Test("When initialized with an existing Failure, it correctly retains the same case")
    func testFailureMapping()
    {
        // Given
        let invalidUrl = "http://example.com"
        let existingFailure = Failure.invalidUrl(invalidUrl)

        // When
        let failure = Failure(existingFailure)

        // Then
        if case .invalidUrl(let url) = failure {
            #expect(url == invalidUrl)
        } else {
            Issue.record("Expected Failure.invalidUrl but got \(failure)")
        }
    }

    @Test("When initialized with a generic error, it maps to the unhandledError case")
    func testUnhandledErrorMapping()
    {
        // Given
        struct CustomError: Error {}
        let customError = CustomError()

        // When
        let failure = Failure(customError)

        // Then
        if case .unhandledError(let error) = failure {
            #expect((error as NSError) == (customError as NSError))
        } else {
            Issue.record("Expected Failure.unhandledError but got \(failure)")
        }
    }
}
