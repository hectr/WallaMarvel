import CoreDomainContracts

/// sourcery: AutoMockable
public protocol MarvelRepositoryProtocol {
    func fetchHeroes(completion: @escaping @Sendable (CharacterModelContainer) -> Void)
    func getHero(heroId: Int, completion: @escaping @Sendable (CharacterModel?) -> Void)
}

public final class MarvelRepository: MarvelRepositoryProtocol
{
    // MARK: Dependencies

    private let local: CharacterModelContainerStoreProtocol
    private let remote: MarvelRemoteDataSourceProtocol

    // MARK: Lifecycle

    public static func make() -> MarvelRepositoryProtocol
    {
        MarvelRepository(
            local: CharacterModelContainerStore.make(),
            remote: MarvelRemoteDataSource.make()
        )
    }

    init(
        local: CharacterModelContainerStoreProtocol,
        remote: MarvelRemoteDataSourceProtocol
    )
    {
        self.local = local
        self.remote = remote
    }

    // MARK: Logic

    public func fetchHeroes(completion: @escaping @Sendable (CharacterModelContainer) -> Void)
    {
        remote.fetchHeroes { [local] dataModel in
            let model = CharacterModelContainer(dataModel)
            Task { @Background in
                local.add(page: model)
            }
            completion(model)
        }
    }

    public func getHero(heroId: Int, completion: @escaping @Sendable (CharacterModel?) -> Void)
    {
        Task { [local] in
            let hero = await local.get(hero: heroId)
            completion(hero)
        }
    }
}
