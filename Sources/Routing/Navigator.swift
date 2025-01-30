import Foundation
import UIKit

/// A navigator is used for managed presentation of view controllers.
///
/// Managed presentation adheres to the Linear Presentation Rules:
/// - Last presented View Controller is the next presenter.
/// - If no View Controller has been presented, Root View Controller is the next presenter
/// sourcery: AutoMockable
@MainActor
public protocol NavigatorProtocol
{
    /// Presents a _modal_ view controller.
    func presentModal(
        _ viewControllerToPresent: UIViewController,
        animated: Bool
    ) -> Presentation?
}

/// Implementation of a stateless navigator (`NavigatorProtocol`).
@MainActor
public struct Navigator: NavigatorProtocol
{
    // MARK: Dependencies

    private let nextPresenter: FindNextPresenterInWindowProtocol
    private let window: UIWindow

    // MARK: Lifecycle

    public static func make(window: UIWindow) -> NavigatorProtocol
    {
        Navigator(
            nextPresenter: FindNextPresenterInWindow.make(),
            window: window
        )
    }

    init(
        nextPresenter: FindNextPresenterInWindowProtocol,
        window: UIWindow
    )
    {
        self.nextPresenter = nextPresenter
        self.window = window
    }

    // MARK: Methods

    public func presentModal(
        _ viewControllerToPresent: UIViewController,
        animated: Bool
    ) -> Presentation?
    {
        // find next presenter view controller
        guard let presenter = self.nextPresenter(in: window) else {
            assertionFailure("Next presenter not found")
            return nil
        }

        // present view controller
        presenter.present(viewControllerToPresent, animated: animated)

        // return presentation object with the dismiss block
        return Presentation(for: viewControllerToPresent) { viewController, animated in
            guard let presenter = viewController.presentingViewController else {
                assertionFailure("\(viewController) is not presented")
                return presenter.dismiss(animated: animated, completion: nil)
            }
            presenter.dismiss(animated: animated, completion: nil)
        }
    }
}
