import UIKit

/// Subclass of `UIViewController` with partial mocking support.
class PartialMockUIViewController: UIViewController
{
    var _presentedViewControllerReturnValue: UIViewController?
    override var presentedViewController: UIViewController?
    {
        get { _presentedViewControllerReturnValue }
    }

    var _presentCallsCount = 0
    var _presentReceivedViewControllerToPresent: UIViewController?
    var _presentReceivedAnimated: Bool?
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        _presentCallsCount += 1
        _presentReceivedViewControllerToPresent = viewControllerToPresent
        _presentReceivedAnimated = flag
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
