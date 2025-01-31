// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Command: Scripts/generate_mocks.sh --target=HeroDetail --import=Routing

 @testable import HeroDetail
 import Routing

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























class MakeHeroDetailDismissMiddlewareProtocolMock: MakeHeroDetailDismissMiddlewareProtocol {




    //MARK: - callAsFunction

    var callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareCallsCount = 0
    var callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareCalled: Bool {
        return callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareCallsCount > 0
    }
    var callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareReceivedPresentationProvider: ((() -> Presentation?))?
    var callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareReceivedInvocations: [((() -> Presentation?))] = []
    var callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareReturnValue: HeroDetailFeature.Store.Middleware!
    var callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareClosure: ((@escaping () -> Presentation?) -> HeroDetailFeature.Store.Middleware)?

    func callAsFunction(presentationProvider: @escaping () -> Presentation?) -> HeroDetailFeature.Store.Middleware {
        callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareCallsCount += 1
        callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareReceivedPresentationProvider = presentationProvider
        callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareReceivedInvocations.append(presentationProvider)
        if let callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareClosure = callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareClosure {
            return callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareClosure(presentationProvider)
        } else {
            return callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareReturnValue
        }
    }


}
class MakeHeroLikeMiddlewareProtocolMock: MakeHeroLikeMiddlewareProtocol {




    //MARK: - callAsFunction

    var callAsFunctionHeroDetailFeatureStoreMiddlewareCallsCount = 0
    var callAsFunctionHeroDetailFeatureStoreMiddlewareCalled: Bool {
        return callAsFunctionHeroDetailFeatureStoreMiddlewareCallsCount > 0
    }
    var callAsFunctionHeroDetailFeatureStoreMiddlewareReturnValue: HeroDetailFeature.Store.Middleware!
    var callAsFunctionHeroDetailFeatureStoreMiddlewareClosure: (() -> HeroDetailFeature.Store.Middleware)?

    func callAsFunction() -> HeroDetailFeature.Store.Middleware {
        callAsFunctionHeroDetailFeatureStoreMiddlewareCallsCount += 1
        if let callAsFunctionHeroDetailFeatureStoreMiddlewareClosure = callAsFunctionHeroDetailFeatureStoreMiddlewareClosure {
            return callAsFunctionHeroDetailFeatureStoreMiddlewareClosure()
        } else {
            return callAsFunctionHeroDetailFeatureStoreMiddlewareReturnValue
        }
    }


}
class PersistentStoreProtocolMock: PersistentStoreProtocol {




    //MARK: - set

    var setValueBoolForKeyDefaultNameStringVoidCallsCount = 0
    var setValueBoolForKeyDefaultNameStringVoidCalled: Bool {
        return setValueBoolForKeyDefaultNameStringVoidCallsCount > 0
    }
    var setValueBoolForKeyDefaultNameStringVoidReceivedArguments: (value: Bool, defaultName: String)?
    var setValueBoolForKeyDefaultNameStringVoidReceivedInvocations: [(value: Bool, defaultName: String)] = []
    var setValueBoolForKeyDefaultNameStringVoidClosure: ((Bool, String) -> Void)?

    func set(_ value: Bool, forKey defaultName: String) {
        setValueBoolForKeyDefaultNameStringVoidCallsCount += 1
        setValueBoolForKeyDefaultNameStringVoidReceivedArguments = (value: value, defaultName: defaultName)
        setValueBoolForKeyDefaultNameStringVoidReceivedInvocations.append((value: value, defaultName: defaultName))
        setValueBoolForKeyDefaultNameStringVoidClosure?(value, defaultName)
    }

    //MARK: - bool

    var boolForKeyDefaultNameStringBoolCallsCount = 0
    var boolForKeyDefaultNameStringBoolCalled: Bool {
        return boolForKeyDefaultNameStringBoolCallsCount > 0
    }
    var boolForKeyDefaultNameStringBoolReceivedDefaultName: (String)?
    var boolForKeyDefaultNameStringBoolReceivedInvocations: [(String)] = []
    var boolForKeyDefaultNameStringBoolReturnValue: Bool!
    var boolForKeyDefaultNameStringBoolClosure: ((String) -> Bool)?

    func bool(forKey defaultName: String) -> Bool {
        boolForKeyDefaultNameStringBoolCallsCount += 1
        boolForKeyDefaultNameStringBoolReceivedDefaultName = defaultName
        boolForKeyDefaultNameStringBoolReceivedInvocations.append(defaultName)
        if let boolForKeyDefaultNameStringBoolClosure = boolForKeyDefaultNameStringBoolClosure {
            return boolForKeyDefaultNameStringBoolClosure(defaultName)
        } else {
            return boolForKeyDefaultNameStringBoolReturnValue
        }
    }


}
public class PresentHeroDetailProtocolMock: PresentHeroDetailProtocol {

    public init() {}



    //MARK: - callAsFunction

    public var callAsFunctionHeroIdIntVoidCallsCount = 0
    public var callAsFunctionHeroIdIntVoidCalled: Bool {
        return callAsFunctionHeroIdIntVoidCallsCount > 0
    }
    public var callAsFunctionHeroIdIntVoidReceivedHeroId: (Int)?
    public var callAsFunctionHeroIdIntVoidReceivedInvocations: [(Int)] = []
    public var callAsFunctionHeroIdIntVoidClosure: ((Int) -> Void)?

    public func callAsFunction(heroId: Int) {
        callAsFunctionHeroIdIntVoidCallsCount += 1
        callAsFunctionHeroIdIntVoidReceivedHeroId = heroId
        callAsFunctionHeroIdIntVoidReceivedInvocations.append(heroId)
        callAsFunctionHeroIdIntVoidClosure?(heroId)
    }


}

