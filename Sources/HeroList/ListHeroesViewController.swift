import Data
import HeroDetail
import SwiftUI
import UIKit
import Routing

public final class ListHeroesViewController: UIViewController {
    var mainView: ListHeroesView { return view as! ListHeroesView  }
    
    let navigator: NavigatorProtocol
    let presenter: ListHeroesPresenterProtocol

    var listHeroesProvider: ListHeroesAdapter?

    public static func make(window: UIWindow) -> UIViewController {
        ListHeroesViewController(
            navigator: Navigator.make(window: window),
            presenter: ListHeroesPresenter.make()
        )
    }

    init(
        navigator: NavigatorProtocol,
        presenter: ListHeroesPresenterProtocol
    ) {
        self.navigator = navigator
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.ui = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = ListHeroesView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        listHeroesProvider = ListHeroesAdapter(tableView: mainView.heroesTableView)
        presenter.getHeroes()
        
        title = presenter.screenTitle()
        
        mainView.heroesTableView.delegate = self
    }
}

extension ListHeroesViewController: ListHeroesUI {
    public func update(heroes: [CharacterDataModel]) {
        listHeroesProvider?.heroes = heroes
    }
}

extension ListHeroesViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = listHeroesProvider?.heroes[indexPath.row].id else {
            assertionFailure("Hero not found")
            return
        }
        let viewController = UIHostingController(rootView: HeroDetailView.make(heroId: id))
        navigator.presentModal(viewController, animated: true)
    }
}

