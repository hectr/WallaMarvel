import Collections
import Foundation

/// sourcery: AutoMockable
public protocol Endpoint
{
    var method: HTTPMethod { get }
    var baseUrl: String { get }
    var path: String { get }
    var query: OrderedDictionary<String, CustomStringConvertible?> { get }
    var responseDeserializer: Deserializer { get }
}

// MARK: - Defaults

extension Endpoint
{
    public var method: HTTPMethod
    { .get }

    public var responseDeserializer: Deserializer
    { JSONDeserializer() }
}
