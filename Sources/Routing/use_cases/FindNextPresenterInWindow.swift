import UIKit

/// A `Navigator` dependency.
/// sourcery: AutoMockable
@MainActor
protocol FindNextPresenterInWindowProtocol
{
    /// Finds, if any, a view controller suitable for presenting a new modal view controller in the given window.
    func callAsFunction (in window: UIWindow) -> UIViewController?
}

@MainActor
struct FindNextPresenterInWindow: FindNextPresenterInWindowProtocol
{
    // MARK: Dependencies
    
    private let nextPresenter: FindNextPresenterInViewControllerProtocol

    // MARK: Lifecycle

    static func make() -> FindNextPresenterInWindowProtocol
    {
        FindNextPresenterInWindow(nextPresenter: FindNextPresenterInViewController.make())
    }

    init(nextPresenter: FindNextPresenterInViewControllerProtocol)
    {
        self.nextPresenter = nextPresenter
    }

    // MARK: Logic

    func callAsFunction (in window: UIWindow) -> UIViewController?
    {
        guard let rootViewController = window.rootViewController else {
            return nil
        }
        return self.nextPresenter (in: rootViewController)
    }
}
