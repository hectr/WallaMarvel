import Foundation
import UIKit

/// A `Presentation` models the_presentation of a view controller_ and encapsulates the logic required to _close_ it.
/// See `Navigator`.
public final class Presentation
{
    // MARK: Dependencies

    public private(set) weak var viewController: UIViewController?
    public let viewControllerType: UIViewController.Type
    private let closeBlock: (_ viewController: UIViewController, _ animated: Bool) -> Void

    // MARK: Lifecycle

    /// Init method used internally by `Navigator` for _managed presentations_.
    init(
        for viewController: UIViewController,
        closeBlock: @escaping (_ viewController: UIViewController, _ animated: Bool) -> Void
    )
    {
        self.viewController = viewController
        self.viewControllerType = type(of: viewController)
        self.closeBlock = closeBlock
    }

    // MARK: Logic

    /// Ends/closes the presentation (e.g. dismissing a modal view controller).
    /// What happens when this method is called depends on the `closeBlock` provided in the initializer.
    public func close(animated: Bool)
    {
        guard let viewController = self.viewController else {
            return
        }
        self.closeBlock(viewController, animated)
    }
}
