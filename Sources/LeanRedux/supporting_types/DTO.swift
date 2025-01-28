/// _Data Transfer Object_ protocol.
public protocol DTO: Codable, Hashable, Sendable
{}

extension DTO
{
    public func with<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> Self
    {
        var mutable = self
        mutable[keyPath: keyPath] = value
        return mutable
    }
}
