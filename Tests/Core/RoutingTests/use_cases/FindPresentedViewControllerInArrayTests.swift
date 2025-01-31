@testable import Routing
@testable import RoutingTestSupport
import Testing
import UIKit

@MainActor @Suite
struct FindPresentedViewControllerInArrayTests
{
    @Test("When array doesn't contain a presenting view controller, then returns nil")
    func noPresentingViewController()
    {
        // Given
        let sut = FindPresentedViewControllerInArray()

        // When
        let viewController = [UIViewController(), UIViewController()]
        let result = sut (in: viewController)

        // Then
        #expect(result == nil)
    }

    @Test("When array contains a presenting view controller, then returns its presented view controller")
    func presentingViewController()
    {
        // Given
        let sut = FindPresentedViewControllerInArray()

        // When
        let presented = UIViewController()
        let presenting = PartialMockUIViewController()
        presenting._presentedViewControllerReturnValue = presented
        let viewController = [UIViewController(), presenting, UIViewController()]
        let result = sut (in: viewController)

        // Then
        #expect(result === presented)
    }

    @Test("When array contains nested presenting view controllers, then returns the presented view controller of the top level presenting view controller")
    func nestedPresentingViewControllers()
    {
        // Given
        let sut = FindPresentedViewControllerInArray()

        // When
        let presentedByPresented = UIViewController()
        let presentedByTopLevelPresenting = PartialMockUIViewController()
        presentedByTopLevelPresenting._presentedViewControllerReturnValue = presentedByPresented
        let topLevelPresenting = PartialMockUIViewController()
        topLevelPresenting._presentedViewControllerReturnValue = presentedByTopLevelPresenting
        let viewController = [UIViewController(), topLevelPresenting, UIViewController()]
        let result = sut (in: viewController)

        // Then
        #expect(result === presentedByTopLevelPresenting)
    }
}
