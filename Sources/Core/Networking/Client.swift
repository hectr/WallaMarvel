import Foundation

public protocol ClientProtocol
{
    @discardableResult
    func performRequest<T: Decodable & Sendable>(
        to endpoint: Endpoint,
        completion: @escaping @Sendable (Result<T, Error>) -> Void
    ) -> OngoingRequest?
}

public final class Client: ClientProtocol
{
    // MARK: Dependencies

    public let provider: NetworkProvider

    // MARK: Lifecycle

    public static func make() -> ClientProtocol
    {
        Client(provider: URLSession.shared)
    }

    init(provider: NetworkProvider)
    {
        self.provider = provider
    }

    // MARK: Logic

    @discardableResult
    public func performRequest<T: Decodable & Sendable>(
        to endpoint: Endpoint,
        completion: @escaping @Sendable (Result<T, Error>) -> Void
    ) -> OngoingRequest?
    {
        let responseDeserializer = endpoint.responseDeserializer
        return provider.performRequest(to: endpoint) { result in
            Self.handleResult(
                result: result,
                deserializer: responseDeserializer,
                completion: completion
            )
        }
    }

    private static func handleResult<T: Decodable & Sendable>(
        result: Result<Data, Error>,
        deserializer: Deserializer,
        completion: @escaping @Sendable (Result<T, Error>) -> Void
    )
    {
        switch result {
        case let .success(data):
            do {
                let value: T = try deserializer.deserialize(data: data)
                completion(Result.success(value))
            } catch {
                let customError: Error
                if let error = error as? Failure {
                    customError = error
                } else {
                    customError = Failure.deserializationError(error)
                }
                completion(Result.failure(customError))
            }

        case let .failure(error):
            completion(Result.failure(error))
        }
    }
}
