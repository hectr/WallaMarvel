import Foundation
import Networking

public class ClientProtocolMock: ClientProtocol
{
    public init()
    {}

    //MARK: - performRequest<T: Decodable & Sendable>

    public var performRequestCallsCount = 0
    public var performRequestCalled: Bool {
        return performRequestCallsCount > 0
    }
    public var performRequestReceivedArguments: (endpoint: Endpoint, completion: Any)?
    public var performRequestReturnValue: OngoingRequest?
    public var performRequestClosure: ((Endpoint, Any) -> OngoingRequest?)?

    @discardableResult
    public func performRequest<T: Decodable & Sendable>(
        to endpoint: Endpoint,
        completion: @Sendable @escaping (Result<T, Error>) -> Void
    ) -> OngoingRequest?
    {
        performRequestCallsCount += 1

        performRequestReceivedArguments = (
            endpoint: endpoint,
            completion: completion
        )

        if let performRequestClosure = performRequestClosure {
            return performRequestClosure(endpoint, completion)
        } else {
            return performRequestReturnValue
        }
    }
}
