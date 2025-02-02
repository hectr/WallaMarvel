import Foundation

/// This mock cannot be used in parallelized tests (!).
///
/// You must ensure that tests using `URLProtocolSerialMock` do not run concurrently.
/// For example you can use the `.serialized` trait (e.g. `@Suite(.serialized)`).
class URLProtocolSerialMock: URLProtocol
{
    nonisolated(unsafe) static private(set) var responseData: Data?
    nonisolated(unsafe) static private(set) var response: URLResponse?
    nonisolated(unsafe) static private(set) var error: Error?

    static func reset(
        responseData: Data? = nil,
        response: URLResponse? = nil,
        error: Error? = nil
    ) {
        Self.responseData = responseData
        Self.response = response
        Self.error = error
    }

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading()
    {
        if let response = URLProtocolSerialMock.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let data = URLProtocolSerialMock.responseData {
            client?.urlProtocol(self, didLoad: data)
        }
        if let error = URLProtocolSerialMock.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading()
    {}
}

