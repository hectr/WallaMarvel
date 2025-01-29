import Foundation
import Data

protocol MarvelRepositoryProtocol {
    func getHeroes(completionBlock: @escaping @Sendable (CharacterDataContainer) -> Void)
}

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol

    static func make() -> MarvelRepositoryProtocol {
        MarvelRepository(dataSource: MarvelDataSource.make())
    }

    init(dataSource: MarvelDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getHeroes(completionBlock: @escaping @Sendable (CharacterDataContainer) -> Void) {
        dataSource.getHeroes(completionBlock: completionBlock)
    }
}
