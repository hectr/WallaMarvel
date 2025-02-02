import CoreDomainContracts

/// This protocol is @MainActor-isolated because of a Swift bug. See `MarvelRepository` for more details.
///
/// sourcery: AutoMockable
@MainActor
public protocol ListHeroesPresenterProtocol: AnyObject
{
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
}

/// This protocol is @MainActor-isolated because of a Swift bug. See `MarvelRepository` for more details.
///
@MainActor
public protocol ListHeroesUI: AnyObject, Sendable
{
    func update(heroes: [CharacterModel])
}

@MainActor
public final class ListHeroesPresenter: ListHeroesPresenterProtocol
{
    public weak var ui: ListHeroesUI?
    private let fetchHeroesUseCase: FetchNextPageProtocol

    public static func make(
        fetchHeroes: FetchNextPageProtocol
    ) -> ListHeroesPresenterProtocol {
        ListHeroesPresenter(fetchHeroesUseCase: fetchHeroes)
    }

    init(fetchHeroesUseCase: FetchNextPageProtocol)
    {
        self.fetchHeroesUseCase = fetchHeroesUseCase
    }

    public func screenTitle() -> String {
        "List of Heroes"
    }

    // MARK: UseCases

    public func getHeroes() {
        guard let ui else {
            assertionFailure("ListHeroesPresenter.ui is nil")
            return
        }
        fetchHeroesUseCase(
            onSuccess: { characterModelContainers in
                Task { @MainActor in
                    ui.update(heroes: characterModelContainers.flatMap { container in container.results })
                }
            },
            onFailure: { _ in }
        )
    }
}

