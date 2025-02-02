import Networking

/// sourcery: AutoMockable
protocol MarvelRemoteDataSourceProtocol
{
    func fetchHeroes(
        limit: Int?,
        offset: Int?,
        onSuccess: @escaping @Sendable (CharacterDataContainer) -> Void,
        onFailure: @escaping @Sendable (Error) -> Void
    )
}

final class MarvelRemoteDataSource: MarvelRemoteDataSourceProtocol
{
    // MARK: Dependencies

    private let apiClient: ClientProtocol
    private let makeEndpoint: MakeCharactersEndpointProtocol

    // MARK: Lifecycle

    static func make() -> MarvelRemoteDataSourceProtocol
    {
        MarvelRemoteDataSource(
            apiClient: Client.make(),
            makeEndpoint: MakeCharactersEndpoint.make()
        )
    }

    init(
        apiClient: ClientProtocol,
        makeEndpoint: MakeCharactersEndpointProtocol
    )
    {
        self.apiClient = apiClient
        self.makeEndpoint = makeEndpoint
    }

    // MARK: Logic

    func fetchHeroes(
        limit: Int?,
        offset: Int?,
        onSuccess: @escaping @Sendable (CharacterDataContainer) -> Void,
        onFailure: @escaping @Sendable (Error) -> Void
    )
    {
        let endpoint = makeEndpoint(
            limit: limit,
            nameStartsWith: nil,
            offset: offset
        )

        _ = apiClient.performRequest(to: endpoint) { (result: Result<CharacterDataContainer, Error>) -> Void in
            switch result {
            case .success(let characterDataContainer):
                onSuccess(characterDataContainer)

            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
