import Foundation
import Data

public protocol GetHeroesUseCaseProtocol {
    func execute(completionBlock: @escaping @Sendable (CharacterDataContainer) -> Void)
}

public struct GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol

    public static func make() -> GetHeroesUseCaseProtocol {
        GetHeroes(repository: MarvelRepository.make())
    }

    init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(completionBlock: @escaping @Sendable (CharacterDataContainer) -> Void) {
        repository.getHeroes(completionBlock: completionBlock)
    }
}
