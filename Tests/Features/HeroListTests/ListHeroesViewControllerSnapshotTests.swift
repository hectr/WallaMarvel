import CoreDomainContracts
@testable import HeroList
@testable import HeroListTestSupport
import SnapshotTesting
import Testing
import UIKit

@Suite(.snapshots(record: .missing, diffTool: .ksdiff)) @MainActor
final class ListHeroesViewControllerSnapshotTests
{
    @Test
    func viewController() async throws
    {
        let presenter = ListHeroesPresenterProtocolMock()
        presenter.screenTitleStringReturnValue = "List of Heroes"
        
        let viewController = ListHeroesViewController(
            presentDetail: { _ in},
            presenter: presenter
        )

        // call viewDidLoad to instantiate `ListHeroesAdapter`
        _ = viewController.view

        let heroes = [
            CharacterModel(
                id: Int(),
                name: "3D-Man",
                heroDescription: String(),
                thumbnail: nil
            ),
            CharacterModel(
                id: Int(),
                name: "Spider-Man",
                heroDescription: String(),
                thumbnail: nil
            )
        ]
        (viewController as ListHeroesUI).update(heroes: heroes)

        assertSnapshot(
            of: UINavigationController(rootViewController: viewController),
            as: .image(on: .iPhoneSe),
            named: "\(UIDevice.current.name).\(UIDevice.current.systemVersion)"
        )
    }
}
