import Foundation

/// Represents various failure cases that can occur in network operations.
public enum Failure: Error
{
    case decodingError(DecodingError)
    case deserializationError(Error)
    case invalidResponse(HTTPURLResponse, Data?)
    case invalidUrl(String)
    case invalidURLQueryItems(String)
    case tooManyURLQueryItems(String, [URLQueryItem])
    case noUrlQueryItemsFound(String)
    case malformedInputURL(URL)
    case malformedOutputURL(URLComponents)
    case unhandledError(Error)
    case urlError(URLError)

    /// This initializer allows seamless conversion of `Swift.Error` instances into more specific `Failure` cases where applicable.
    public init(_ error: Swift.Error)
    {
        if let error = error as? DecodingError {
            self = .decodingError(error)
        } else if let error = error as? Failure {
            self = error
        } else if let error = error as? URLError {
            self = .urlError(error)
        } else {
            self = .unhandledError(error)
        }
    }
}
