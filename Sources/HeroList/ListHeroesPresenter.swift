import Foundation
import Data
import Domain

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
}

@MainActor
protocol ListHeroesUI: AnyObject, Sendable {
    func update(heroes: [CharacterDataModel])
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    public weak var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol

    static func make() -> ListHeroesPresenterProtocol {
        ListHeroesPresenter(getHeroesUseCase: GetHeroes.make())
    }

    init(getHeroesUseCase: GetHeroesUseCaseProtocol) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes() {
        guard let ui else {
            assertionFailure("ListHeroesPresenter.ui is nil")
            return
        }
        getHeroesUseCase.execute { characterDataContainer in
            print("Characters \(characterDataContainer.characters)")
            Task { @MainActor in 
                ui.update(heroes: characterDataContainer.characters)
            }
        }
    }
}

