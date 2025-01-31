// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Command: Scripts/generate_mocks.sh --target=Routing

 @testable import Routing

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























class FindNextPresenterInViewControllerProtocolMock: FindNextPresenterInViewControllerProtocol {




    //MARK: - callAsFunction

    var callAsFunctionInViewControllerUIViewControllerUIViewControllerCallsCount = 0
    var callAsFunctionInViewControllerUIViewControllerUIViewControllerCalled: Bool {
        return callAsFunctionInViewControllerUIViewControllerUIViewControllerCallsCount > 0
    }
    var callAsFunctionInViewControllerUIViewControllerUIViewControllerReceivedViewController: (UIViewController)?
    var callAsFunctionInViewControllerUIViewControllerUIViewControllerReceivedInvocations: [(UIViewController)] = []
    var callAsFunctionInViewControllerUIViewControllerUIViewControllerReturnValue: UIViewController!
    var callAsFunctionInViewControllerUIViewControllerUIViewControllerClosure: ((UIViewController) -> UIViewController)?

    func callAsFunction(in viewController: UIViewController) -> UIViewController {
        callAsFunctionInViewControllerUIViewControllerUIViewControllerCallsCount += 1
        callAsFunctionInViewControllerUIViewControllerUIViewControllerReceivedViewController = viewController
        callAsFunctionInViewControllerUIViewControllerUIViewControllerReceivedInvocations.append(viewController)
        if let callAsFunctionInViewControllerUIViewControllerUIViewControllerClosure = callAsFunctionInViewControllerUIViewControllerUIViewControllerClosure {
            return callAsFunctionInViewControllerUIViewControllerUIViewControllerClosure(viewController)
        } else {
            return callAsFunctionInViewControllerUIViewControllerUIViewControllerReturnValue
        }
    }


}
class FindNextPresenterInWindowProtocolMock: FindNextPresenterInWindowProtocol {




    //MARK: - callAsFunction

    var callAsFunctionInWindowUIWindowUIViewControllerCallsCount = 0
    var callAsFunctionInWindowUIWindowUIViewControllerCalled: Bool {
        return callAsFunctionInWindowUIWindowUIViewControllerCallsCount > 0
    }
    var callAsFunctionInWindowUIWindowUIViewControllerReceivedWindow: (UIWindow)?
    var callAsFunctionInWindowUIWindowUIViewControllerReceivedInvocations: [(UIWindow)] = []
    var callAsFunctionInWindowUIWindowUIViewControllerReturnValue: UIViewController?
    var callAsFunctionInWindowUIWindowUIViewControllerClosure: ((UIWindow) -> UIViewController?)?

    func callAsFunction(in window: UIWindow) -> UIViewController? {
        callAsFunctionInWindowUIWindowUIViewControllerCallsCount += 1
        callAsFunctionInWindowUIWindowUIViewControllerReceivedWindow = window
        callAsFunctionInWindowUIWindowUIViewControllerReceivedInvocations.append(window)
        if let callAsFunctionInWindowUIWindowUIViewControllerClosure = callAsFunctionInWindowUIWindowUIViewControllerClosure {
            return callAsFunctionInWindowUIWindowUIViewControllerClosure(window)
        } else {
            return callAsFunctionInWindowUIWindowUIViewControllerReturnValue
        }
    }


}
class FindPresentedViewControllerInArrayProtocolMock: FindPresentedViewControllerInArrayProtocol {




    //MARK: - callAsFunction

    var callAsFunctionInViewControllersUIViewControllerUIViewControllerCallsCount = 0
    var callAsFunctionInViewControllersUIViewControllerUIViewControllerCalled: Bool {
        return callAsFunctionInViewControllersUIViewControllerUIViewControllerCallsCount > 0
    }
    var callAsFunctionInViewControllersUIViewControllerUIViewControllerReceivedViewControllers: ([UIViewController])?
    var callAsFunctionInViewControllersUIViewControllerUIViewControllerReceivedInvocations: [([UIViewController])] = []
    var callAsFunctionInViewControllersUIViewControllerUIViewControllerReturnValue: UIViewController?
    var callAsFunctionInViewControllersUIViewControllerUIViewControllerClosure: (([UIViewController]) -> UIViewController?)?

    func callAsFunction(in viewControllers: [UIViewController]) -> UIViewController? {
        callAsFunctionInViewControllersUIViewControllerUIViewControllerCallsCount += 1
        callAsFunctionInViewControllersUIViewControllerUIViewControllerReceivedViewControllers = viewControllers
        callAsFunctionInViewControllersUIViewControllerUIViewControllerReceivedInvocations.append(viewControllers)
        if let callAsFunctionInViewControllersUIViewControllerUIViewControllerClosure = callAsFunctionInViewControllersUIViewControllerUIViewControllerClosure {
            return callAsFunctionInViewControllersUIViewControllerUIViewControllerClosure(viewControllers)
        } else {
            return callAsFunctionInViewControllersUIViewControllerUIViewControllerReturnValue
        }
    }


}
public class NavigatorProtocolMock: NavigatorProtocol {

    public init() {}



    //MARK: - presentModal

    public var presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationCallsCount = 0
    public var presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationCalled: Bool {
        return presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationCallsCount > 0
    }
    public var presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationReceivedArguments: (viewControllerToPresent: UIViewController, animated: Bool)?
    public var presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationReceivedInvocations: [(viewControllerToPresent: UIViewController, animated: Bool)] = []
    public var presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationReturnValue: Presentation?
    public var presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationClosure: ((UIViewController, Bool) -> Presentation?)?

    public func presentModal(_ viewControllerToPresent: UIViewController, animated: Bool) -> Presentation? {
        presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationCallsCount += 1
        presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationReceivedArguments = (viewControllerToPresent: viewControllerToPresent, animated: animated)
        presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationReceivedInvocations.append((viewControllerToPresent: viewControllerToPresent, animated: animated))
        if let presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationClosure = presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationClosure {
            return presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationClosure(viewControllerToPresent, animated)
        } else {
            return presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationReturnValue
        }
    }


}

