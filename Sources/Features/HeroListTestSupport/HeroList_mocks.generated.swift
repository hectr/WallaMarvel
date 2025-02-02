// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Command: Scripts/generate_mocks.sh --target=HeroList --sources-path=Sources/Features

@testable import HeroList

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























public class ListHeroesPresenterProtocolMock: ListHeroesPresenterProtocol {

    public init() {}

    public var ui: ListHeroesUI?


    //MARK: - screenTitle

    public var screenTitleStringCallsCount = 0
    public var screenTitleStringCalled: Bool {
        return screenTitleStringCallsCount > 0
    }
    public var screenTitleStringReturnValue: String!
    public var screenTitleStringClosure: (() -> String)?

    public func screenTitle() -> String {
        screenTitleStringCallsCount += 1
        if let screenTitleStringClosure = screenTitleStringClosure {
            return screenTitleStringClosure()
        } else {
            return screenTitleStringReturnValue
        }
    }

    //MARK: - getHeroes

    public var getHeroesVoidCallsCount = 0
    public var getHeroesVoidCalled: Bool {
        return getHeroesVoidCallsCount > 0
    }
    public var getHeroesVoidClosure: (() -> Void)?

    public func getHeroes() {
        getHeroesVoidCallsCount += 1
        getHeroesVoidClosure?()
    }


}

