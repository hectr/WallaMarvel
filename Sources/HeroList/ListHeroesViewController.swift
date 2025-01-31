import DomainContracts
import SwiftUI
import UIKit

public final class ListHeroesViewController: UIViewController {
    var mainView: ListHeroesView { return view as! ListHeroesView  }
    
    let presentDetail: (Int) -> Void
    let presenter: ListHeroesPresenterProtocol

    var listHeroesProvider: ListHeroesAdapter?

    public static func make(
        presenter: ListHeroesPresenterProtocol,
        presentDetail: @escaping (Int) -> Void
    ) -> UIViewController {
        ListHeroesViewController(
            presentDetail: presentDetail,
            presenter: presenter
        )
    }

    init(
        presentDetail: @escaping (Int) -> Void,
        presenter: ListHeroesPresenterProtocol
    ) {
        self.presentDetail = presentDetail
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
    public func update(heroes: [CharacterModel]) {
        listHeroesProvider?.heroes = heroes
    }
}

extension ListHeroesViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = listHeroesProvider?.heroes[indexPath.row].id else {
            assertionFailure("Hero not found")
            return
        }
        presentDetail(id)
    }
}
