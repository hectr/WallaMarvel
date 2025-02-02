import CoreDomainContracts

@MainActor
public struct GetHero: GetHeroProtocol
{
    // MARK: Dependencies

    private let repository: MarvelRepositoryProtocol

    // MARK: Lifecycle

    public static func make(repository: MarvelRepositoryProtocol) -> GetHeroProtocol
    {
        GetHero(repository: repository)
    }

    init(repository: MarvelRepositoryProtocol)
    {
        self.repository = repository
    }

    // MARK: Logic

    public func callAsFunction(heroId: Int, completion: @escaping @Sendable (CharacterModel?) -> Void)
    {
        repository.getHero(heroId: heroId, completion: completion)

    }
}
