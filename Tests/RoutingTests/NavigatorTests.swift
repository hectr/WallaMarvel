@testable import Routing
@testable import RoutingTestSupport
import Testing
import UIKit

@MainActor @Suite
struct NavigatorTests
{
    @Test("When present modal is received, then uses 'find next presenter' dependency")
    func findNextPresenter() {
        // Given
        let findNextPresenter = FindNextPresenterInWindowProtocolMock()
        let sut = Navigator(
            nextPresenter: findNextPresenter,
            window: UIWindow()
        )

        // When
        _ = sut.presentModal(
            UIViewController(),
            animated: true
        )

        // Then
        #expect(findNextPresenter.callAsFunctionInWindowUIWindowUIViewControllerCallsCount == 1)
    }

    @Test("When present modal is received and next presenter is found, then does presentation")
    func presenterFound() {
        // Given
        let findNextPresenter = FindNextPresenterInWindowProtocolMock()
        let presenter = PartialMockUIViewController()
        findNextPresenter.callAsFunctionInWindowUIWindowUIViewControllerReturnValue = presenter
        let sut = Navigator(
            nextPresenter: findNextPresenter,
            window: UIWindow()
        )
        let viewControllerToPresent = UIViewController()

        // When
        _ = sut.presentModal(
            viewControllerToPresent,
            animated: true
        )

        // Then
        #expect(presenter._presentCallsCount == 1)
        #expect(presenter._presentReceivedViewControllerToPresent === viewControllerToPresent)
        #expect(presenter._presentReceivedAnimated == true)
    }
}
