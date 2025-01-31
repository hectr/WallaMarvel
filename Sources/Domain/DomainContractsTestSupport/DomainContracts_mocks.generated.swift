// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Command: Scripts/generate_mocks.sh --target=DomainContracts

 @testable import DomainContracts

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

























public class GetHeroesProtocolMock: GetHeroesProtocol {

    public init() {}



    //MARK: - callAsFunction

    public var callAsFunctionCompletionSendableEscapingCharacterModelContainerVoidVoidCallsCount = 0
    public var callAsFunctionCompletionSendableEscapingCharacterModelContainerVoidVoidCalled: Bool {
        return callAsFunctionCompletionSendableEscapingCharacterModelContainerVoidVoidCallsCount > 0
    }
    public var callAsFunctionCompletionSendableEscapingCharacterModelContainerVoidVoidReceivedCompletion: (((CharacterModelContainer) -> Void))?
    public var callAsFunctionCompletionSendableEscapingCharacterModelContainerVoidVoidReceivedInvocations: [(((CharacterModelContainer) -> Void))] = []
    public var callAsFunctionCompletionSendableEscapingCharacterModelContainerVoidVoidClosure: ((@Sendable @escaping (CharacterModelContainer) -> Void) -> Void)?

    public func callAsFunction(completion: @Sendable @escaping (CharacterModelContainer) -> Void) {
        callAsFunctionCompletionSendableEscapingCharacterModelContainerVoidVoidCallsCount += 1
        callAsFunctionCompletionSendableEscapingCharacterModelContainerVoidVoidReceivedCompletion = completion
        callAsFunctionCompletionSendableEscapingCharacterModelContainerVoidVoidReceivedInvocations.append(completion)
        callAsFunctionCompletionSendableEscapingCharacterModelContainerVoidVoidClosure?(completion)
    }


}

