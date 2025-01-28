import Foundation

@MainActor
protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
}

@MainActor
protocol ListHeroesUI: AnyObject, Sendable {
    func update(heroes: [CharacterDataModel])
}

@MainActor
final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    weak var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = GetHeroes()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes() {
        getHeroesUseCase.execute { characterDataContainer in
            print("Characters \(characterDataContainer.characters)")
            await self.ui?.update(heroes: characterDataContainer.characters)
        }
    }
}

