import DataContracts

public final class MarvelRemoteDataSource: MarvelRemoteDataSourceProtocol {
    private let apiClient: APIClientProtocol

    public static func make() -> MarvelRemoteDataSourceProtocol {
        MarvelRemoteDataSource(apiClient: APIClient())
    }

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    public func fetchHeroes(completion: @escaping @Sendable (CharacterDataContainer) -> Void) {
        return apiClient.getHeroes(completionBlock: completion)
    }
}
