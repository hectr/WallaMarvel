@testable import Networking
@testable import NetworkingTestSupport
import Testing
import Foundation

@Suite(.serialized)
struct URLSessionNetworkProviderTests
{
    private func makeSut() -> URLSession
    {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolSerialMock.self]
        return URLSession(configuration: configuration)
    }

    private func makeEndpoint() -> Endpoint
    {
        let endpoint = EndpointMock()
        endpoint.underlyingBaseUrl = "http://example.com"
        endpoint.underlyingQuery = ["key": "value"]
        endpoint.underlyingPath = "path"
        endpoint.underlyingMethod = .get
        return endpoint
    }

    @Test("When performing a request, it returns expected success data")
    func testSuccessfulRequest() async throws
    {
        // Given
        let session = makeSut()
        let endpoint = makeEndpoint()
        let expectedData = "Mock response".data(using: .utf8)
        URLProtocolSerialMock.reset(
            responseData: expectedData,
            response: HTTPURLResponse(
                url: URL(string: "http://example.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
        )

        // When
        let result = await withCheckedContinuation { continuation in
            _ = session.performRequest(to: endpoint) { result in
                continuation.resume(returning: result)
            }
        }

        // Then
        #expect((try? result.get()) == expectedData)
    }

    @Test("When receiving an HTTP error, it returns an invalidResponse failure")
    func testHttpErrorResponse() async
    {
        // Given
        let session = makeSut()
        let endpoint = makeEndpoint()
        URLProtocolSerialMock.reset(
            response: HTTPURLResponse(
                url: URL(string: "http://example.com")!,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )
        )

        // When
        let result = await withCheckedContinuation { continuation in
            _ = session.performRequest(to: endpoint) { result in
                continuation.resume(returning: result)
            }
        }

        // Then
        if case .failure(let error) = result,
           let failure = error as? Failure,
           case .invalidResponse(let response, _) = failure {
            #expect(response.statusCode == 404)
        } else {
            Issue.record("Expected invalidResponse error but got \(result)")
        }
    }

    @Test("When a network failure occurs, it returns a URLError failure")
    func testNetworkFailure() async
    {
        // Given
        let session = makeSut()
        let endpoint = makeEndpoint()
        let networkError = URLError(.timedOut)
        URLProtocolSerialMock.reset(
            responseData: nil,
            error: networkError
        )

        // When
        let result = await withCheckedContinuation { continuation in
            _ = session.performRequest(to: endpoint) { result in
                continuation.resume(returning: result)
            }
        }

        // Then
        if case .failure(let error) = result,
           let failure = error as? Failure,
           case .urlError(let urlError) = failure {
            #expect(urlError.code == .timedOut)
        } else {
            Issue.record("Expected urlError but got \(result)")
        }
    }
}
