import UIKit

/// Subclass of `UIViewController` with partial mocking support.
class PartialMockUIViewController: UIViewController
{
    var _presentedViewControllerReturnValue: UIViewController?
    override var presentedViewController: UIViewController?
    {
        get { _presentedViewControllerReturnValue }
    }
}
