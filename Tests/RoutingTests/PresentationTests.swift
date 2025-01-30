@testable import Routing
@testable import RoutingTestSupport
import Testing
import UIKit

@MainActor @Suite
struct PresentationTests
{
    @Test("When close is called, the presentation should be dismissed")
    func viewController() {
        // Given
        let viewController = UIViewController()
        var receivedViewController: UIViewController?
        var receivedAnimated: Bool?
        let presentation = Presentation(for: viewController) { viewController, animated in
            receivedViewController = viewController
            receivedAnimated = animated
        }

        // When
        presentation.close(animated: true)

        // Then
        #expect(receivedViewController === viewController)
        #expect(receivedAnimated == true)
    }

    @Test("When close is called, but view controller is nil, the presentation should be dismissed")
    func nilViewController() {
        // Given
        var viewController: UIViewController? = UIViewController()
        var receivedViewController: UIViewController?
        var receivedAnimated: Bool?
        let presentation = Presentation(for: viewController!) { viewController, animated in
            receivedViewController = viewController
            receivedAnimated = animated
        }
        viewController = nil

        // When
        presentation.close(animated: true)

        // Then
        #expect(receivedViewController == nil)
        #expect(receivedAnimated == nil)
    }
}
