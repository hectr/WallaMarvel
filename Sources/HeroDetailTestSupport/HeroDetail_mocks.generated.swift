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

