import Foundation

public protocol MarvelDataSourceProtocol {
    func getHeroes(completionBlock: @escaping @Sendable (CharacterDataContainer) -> Void)
}

public final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol

    public static func make() -> MarvelDataSourceProtocol {
        MarvelDataSource(apiClient: APIClient())
    }

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    public func getHeroes(completionBlock: @escaping @Sendable (CharacterDataContainer) -> Void) {
        return apiClient.getHeroes(completionBlock: completionBlock)
    }
}
