import DataContracts
import DomainContracts

public struct GetHeroes: GetHeroesProtocol
{
    // MARK: Dependencies

    private let repository: MarvelRepositoryProtocol

    // MARK: Lifecycle

    public static func make(repository: MarvelRepositoryProtocol) -> GetHeroesProtocol
    {
        GetHeroes(repository: repository)
    }

    init(repository: MarvelRepositoryProtocol)
    {
        self.repository = repository
    }

    // MARK: Logic

    public func callAsFunction(completionBlock: @escaping @Sendable (CharacterModelContainer) -> Void)
    {
        repository.getHeroes { dataModel in
            let model = CharacterModelContainer(dataModel)
            completionBlock(model)
        }
    }
}
