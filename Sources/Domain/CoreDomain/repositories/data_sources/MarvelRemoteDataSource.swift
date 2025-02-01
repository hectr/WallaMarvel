/// sourcery: AutoMockable
protocol MarvelRemoteDataSourceProtocol
{
    func fetchHeroes(completion: @escaping @Sendable (CharacterDataContainer) -> Void)
}

final class MarvelRemoteDataSource: MarvelRemoteDataSourceProtocol {
    private let apiClient: APIClientProtocol

    static func make() -> MarvelRemoteDataSourceProtocol {
        MarvelRemoteDataSource(apiClient: APIClient())
    }

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchHeroes(completion: @escaping @Sendable (CharacterDataContainer) -> Void) {
        return apiClient.getHeroes(completionBlock: completion)
    }
}
