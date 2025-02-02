@testable import CoreDomainContracts
@testable import CoreDomainContractsTestSupport
@testable import HeroList
@testable import HeroListTestSupport
import Testing
import UIKit

@Suite @MainActor
final class ListHeroesViewControllerTests
{
    @Test("When viewDidLoad called, then listHeroesProvider is initialized")
    func viewDidLoad() throws
    {
        // Given
        let presenter = ListHeroesPresenterProtocolMock()
        presenter.screenTitleStringReturnValue = "List of Heroes"

        let viewController = ListHeroesViewController(
            presentDetail: { _ in},
            presenter: presenter
        )
        try #require(viewController.listHeroesProvider == nil)

        // When
        viewController.viewDidLoad()

        // Then
        #expect(viewController.listHeroesProvider != nil)
    }

    @Test("When row is selected, then detail is presented")
    func didSelect()
    {
        // Given
        let presenter = ListHeroesPresenterProtocolMock()
        presenter.screenTitleStringReturnValue = "List of Heroes"

        var presentDetailCallesCount = 0
        var receivedHeroId = Int?.none
        let viewController = ListHeroesViewController(
            presentDetail: { heroId in receivedHeroId = heroId; presentDetailCallesCount += 1 },
            presenter: presenter
        )
        viewController.listHeroesProvider = ListHeroesAdapter(
            tableView: UITableView(),
            heroes: [
                CharacterModel(
                    id: 15,
                    name: "3D-Man",
                    heroDescription: String(),
                    thumbnail: nil
                ),
            ]
        )

        // When
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))

        // Then
        #expect(presentDetailCallesCount == 1)
        #expect(receivedHeroId == 15)
    }
}
