import UIKit

/// sourcery: AutoMockable
@MainActor
protocol FindPresentedViewControllerInArrayProtocol
{
    /// Finds, if any, the view controller presented by any of the given view controllers.
    func callAsFunction(in viewControllers: [UIViewController]) -> UIViewController?
}

@MainActor
struct FindPresentedViewControllerInArray: FindPresentedViewControllerInArrayProtocol
{
    // MARK: Lifecycle
    
    static func make() -> FindPresentedViewControllerInArrayProtocol
    {
        FindPresentedViewControllerInArray()
    }

    // MARK: Logic

    func callAsFunction(in viewControllers: [UIViewController]) -> UIViewController?
    {
        for viewController in viewControllers {
            guard let presentedViewController = viewController.presentedViewController else {
                continue
            }
            // there is a presented view controller, return it
            return presentedViewController
        }
        // none of the received view controllers is a presenting view controller, return nil
        return nil
    }
}
