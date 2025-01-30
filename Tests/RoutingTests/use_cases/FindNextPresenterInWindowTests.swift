@testable import Routing
@testable import RoutingTestSupport
import Testing
import UIKit

@MainActor @Suite
struct FindNextPresenterInWindowTests
{
    @Test("When window has not root view controller, then returns nil")
    func noRootViewController() {
        // Given
        let nextPresenter = FindNextPresenterInViewControllerProtocolMock()
        let sut = FindNextPresenterInWindow(nextPresenter: nextPresenter)

        // When
        let window = UIWindow()
        let result = sut(in: window)

        // Then
        #expect(result == nil)
        #expect(nextPresenter.callAsFunctionInViewControllerUIViewControllerUIViewControllerCallsCount == 0)
    }

    @Test("When window has root view controller, then returns next presenter")
    func rootViewController() {
        // Given
        let nextPresenter = FindNextPresenterInViewControllerProtocolMock()
        let sut = FindNextPresenterInWindow(nextPresenter: nextPresenter)
        nextPresenter.callAsFunctionInViewControllerUIViewControllerUIViewControllerReturnValue = UIViewController()

        // When
        let window = UIWindow()
        window.rootViewController = UIViewController()
        let result = sut(in: window)

        // Then
        #expect(result != nil)
        #expect(nextPresenter.callAsFunctionInViewControllerUIViewControllerUIViewControllerCallsCount == 1)
        #expect(nextPresenter.callAsFunctionInViewControllerUIViewControllerUIViewControllerReceivedInvocations.last === window.rootViewController)
        #expect(result === nextPresenter.callAsFunctionInViewControllerUIViewControllerUIViewControllerReturnValue)
    }
}
