import Foundation

/// Represents an HTTP method used in network requests.
public enum HTTPMethod: Hashable, Sendable
{
    case get
    case custom(String)

    public var verb: String {
        switch self {
        case .get:
            return "GET"

        case let .custom(verb):
            return verb
        }
    }

    // MARK: Equatable

    /// Two `HTTPMethod` values are considered equal if their `verb` properties match.
    public static func == (lhs: HTTPMethod, rhs: HTTPMethod) -> Bool
    {
        lhs.verb == rhs.verb
    }
}
