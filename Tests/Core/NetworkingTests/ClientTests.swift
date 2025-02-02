@testable import Networking
@testable import NetworkingTestSupport
import Testing
import Foundation

@Suite
struct ClientTests
{

    @Test("When performing a request, it invokes the network provider")
    func testPerformRequestInvokesProvider()
    {
        // Given
        let provider = NetworkProviderMock()
        let client = Client(provider: provider)
        let endpoint = EndpointMock()
        endpoint.underlyingResponseDeserializer = JSONDeserializer()

        provider.performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestClosure = { _, completion in
            completion(.success(Data()))
            return OngoingRequestMock()
        }

        // When
        let request = client.performRequest(to: endpoint) { (_: Result<String, Error>) in }

        // Then
        #expect(provider.performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestCallsCount == 1)
        #expect(request != nil)
    }

    @Test("When the network provider returns success, the client deserializes the response")
    func testPerformRequestSuccess() async
    {
        // Given
        let provider = NetworkProviderMock()
        let client = Client(provider: provider)
        let endpoint = EndpointMock()
        endpoint.underlyingResponseDeserializer = JSONDeserializer()
        let expectedData = "{\"message\": \"Hello, World!\"}".data(using: .utf8)!
        let deserializer = JSONDeserializer()

        endpoint.responseDeserializer = deserializer
        provider.performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestClosure = { _, completion in
            completion(.success(expectedData))
            return OngoingRequestMock()
        }

        // When
        let result = await withCheckedContinuation { continuation in
            client.performRequest(to: endpoint) { (response: Result<[String: String], Error>) in
                continuation.resume(returning: response)
            }
        }

        // Then
        if case .success(let jsonResponse) = result {
            #expect(jsonResponse["message"] == "Hello, World!")
        } else {
            Issue.record("Expected success but got \(result)")
        }
    }

    @Test("When deserialization fails, the client returns a deserialization error")
    func testPerformRequestDeserializationFailure() async
    {
        // Given
        let provider = NetworkProviderMock()
        let client = Client(provider: provider)
        let endpoint = EndpointMock()
        endpoint.underlyingResponseDeserializer = JSONDeserializer()
        let invalidData = "invalid json".data(using: .utf8)!

        endpoint.responseDeserializer = JSONDeserializer()
        provider.performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestClosure = { _, completion in
            completion(.success(invalidData))
            return OngoingRequestMock()
        }

        // When
        let result = await withCheckedContinuation { continuation in
            client.performRequest(to: endpoint) { (response: Result<[String: String], Error>) in
                continuation.resume(returning: response)
            }
        }

        // Then
        if case .failure(let error) = result, case .deserializationError = error as? Failure {
            #expect(true)
        } else {
            Issue.record("Expected deserialization error but got \(result)")
        }
    }
}
