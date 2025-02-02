import Foundation

public protocol OngoingRequest: Sendable
{}

/// sourcery: AutoMockable
public protocol NetworkProvider
{
    typealias Completion = @Sendable (Result<Data, Error>) -> Void

    func performRequest(to endpoint: Endpoint, completion: @escaping Completion) -> OngoingRequest?
}
