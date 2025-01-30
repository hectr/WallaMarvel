@testable import Routing
@testable import RoutingTestSupport
import Testing
import UIKit

@MainActor @Suite
struct FindNextPresenterInViewControllerTests
{
    @Test("When UIViewController is presented, then returns as expected")
    func viewControllerPresented ()
    {
        // Given
        let sut = FindNextPresenterInViewController.make()

        // When
        let viewController = PartialMockUIViewController()
        let presentedViewController = PartialMockUIViewController()
        viewController._presentedViewControllerReturnValue = presentedViewController
        presentedViewController._presentedViewControllerReturnValue = UIViewController()
        let result = sut(in: viewController)

        // Then
        #expect(result != nil)
        #expect(result === presentedViewController._presentedViewControllerReturnValue)
    }

    @Test("When UINavigationController's 'visible controller' is the presenter, then returns as expected")
    func visibleControllerIsPresenting()
    {
        // Given
        let sut = FindNextPresenterInViewController.make()

        // When
        let viewController = PartialMockUIViewController()
        let visibleViewController = PartialMockUIViewController()
        let presentedViewController = UINavigationController(rootViewController: visibleViewController)
        viewController._presentedViewControllerReturnValue = presentedViewController
        visibleViewController._presentedViewControllerReturnValue = UIViewController()
        let result = sut(in: viewController)

        // Then
        #expect(result != nil)
        #expect(result === visibleViewController._presentedViewControllerReturnValue)
    }
}
