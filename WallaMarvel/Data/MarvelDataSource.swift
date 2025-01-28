import Foundation

protocol MarvelDataSourceProtocol {
    func getHeroes(completionBlock: @escaping @Sendable (CharacterDataContainer) async -> Void)
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getHeroes(completionBlock: @escaping @Sendable (CharacterDataContainer) async -> Void) {
        return apiClient.getHeroes(completionBlock: completionBlock)
    }
}
