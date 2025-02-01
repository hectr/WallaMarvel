import CoreDomainContracts

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

    public func callAsFunction(completion: @escaping @Sendable (CharacterModelContainer) -> Void)
    {
        repository.fetchHeroes(completion: completion)
    }
}
