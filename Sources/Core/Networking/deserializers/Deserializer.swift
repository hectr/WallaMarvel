import Foundation

public protocol Deserializer: Sendable
{
    func deserialize<T: Decodable>(data: Data) throws -> T
}
