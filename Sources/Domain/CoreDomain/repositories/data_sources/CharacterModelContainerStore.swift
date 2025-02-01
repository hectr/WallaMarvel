import CoreDomainContracts

/// sourcery: AutoMockable
@Background
protocol CharacterModelContainerStoreProtocol: Sendable
{
    func add(page: CharacterModelContainer)
    func get(hero id: Int) -> CharacterModel?
}

@Background
final class CharacterModelContainerStore: CharacterModelContainerStoreProtocol
{
    // MARK: State

    var heroes: [CharacterModel]

    // MARK: Lifecycle

    nonisolated static func make() -> CharacterModelContainerStoreProtocol
    {
        CharacterModelContainerStore(heroes: [])
    }

    nonisolated init(heroes: [CharacterModel])
    {
        self.heroes = heroes
    }

    // MARK: Logic

    func add(page: CharacterModelContainer)
    {
        heroes.append(contentsOf: page.results)
    }

    func get(hero id: Int) -> CharacterModel?
    {
        return heroes.first { hero in
            hero.id == id
        }
    }
}
