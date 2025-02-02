import CoreDomainContracts

public protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
}

@MainActor
public protocol ListHeroesUI: AnyObject, Sendable {
    func update(heroes: [CharacterModel])
}

public final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    public weak var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesProtocol

    public static func make(getHeroes: GetHeroesProtocol) -> ListHeroesPresenterProtocol {
        ListHeroesPresenter(getHeroesUseCase: getHeroes)
    }

    init(getHeroesUseCase: GetHeroesProtocol) {
        self.getHeroesUseCase = getHeroesUseCase
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
        getHeroesUseCase { characterModelContainer in
            Task { @MainActor in
                ui.update(heroes: characterModelContainer.results)
            }
        }
    }
}

