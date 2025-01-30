import UIKit

/// A `Navigator` dependency.
/// sourcery: AutoMockable
@MainActor
protocol FindNextPresenterInViewControllerProtocol
{
    /// Finds, if any, a view controller suitable for presenting a new modal view controller in the given view controller.
    func callAsFunction(in viewController: UIViewController) -> UIViewController
}

/// Use case that finds a view controller suitable for presenting a modal view controller.
/// See `NavigatorProtocol` (_Linear Presentation Rules_).
@MainActor
struct FindNextPresenterInViewController: FindNextPresenterInViewControllerProtocol
{
    // MARK: Dependencies

    private let findPresentedViewController: FindPresentedViewControllerInArrayProtocol

    // MARK: Lifecycle

    static func make() -> FindNextPresenterInViewControllerProtocol
    {
        FindNextPresenterInViewController(findPresentedViewController: FindPresentedViewControllerInArray.make())
    }

    init(findPresentedViewController: FindPresentedViewControllerInArrayProtocol)
    {
        self.findPresentedViewController = findPresentedViewController
    }

    // MARK: Logic

    func callAsFunction(in viewController: UIViewController) -> UIViewController
    {
        guard let presentedViewController = viewController.presentedViewController else {
            return self.findNextSubPresenter(in: viewController) ?? viewController
        }
        return self(in: presentedViewController)
    }

    /// Finds any child view controller that is presenting a modal flow.
    /// This adds flexibility for cases where a third party is doing unmanaged presentations without following _Linear Presentation Rules_.
    private func findNextSubPresenter(in presenterCandidate: UIViewController) -> UIViewController?
    {
        // check if view controllers contained in the candidate are presenting view controllers
        if let navigationController = presenterCandidate as? UINavigationController,
           let visibleViewController = navigationController.visibleViewController,
           let presentedViewController = self.findPresentedViewController(in: [visibleViewController]) {
            return self(in: presentedViewController)
        } // else { ...add other special cases handling here (e.g. UITabBarController)... }
        return nil
    }
}
