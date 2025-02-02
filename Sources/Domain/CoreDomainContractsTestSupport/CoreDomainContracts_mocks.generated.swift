// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Command: Scripts/generate_mocks.sh --target=CoreDomainContracts --sources-path=Sources/Domain

@testable import CoreDomainContracts

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























public class FetchNextPageProtocolMock: FetchNextPageProtocol {

    public init() {}



    //MARK: - callAsFunction

    public var callAsFunctionOnSuccessSendableEscapingAllPagesAllPagesVoidOnFailureSendableEscapingErrorErrorVoidVoidCallsCount = 0
    public var callAsFunctionOnSuccessSendableEscapingAllPagesAllPagesVoidOnFailureSendableEscapingErrorErrorVoidVoidCalled: Bool {
        return callAsFunctionOnSuccessSendableEscapingAllPagesAllPagesVoidOnFailureSendableEscapingErrorErrorVoidVoidCallsCount > 0
    }
    public var callAsFunctionOnSuccessSendableEscapingAllPagesAllPagesVoidOnFailureSendableEscapingErrorErrorVoidVoidReceivedArguments: (onSuccess: (_ allPages: AllPages) -> Void, onFailure: (_ error: Error) -> Void)?
    public var callAsFunctionOnSuccessSendableEscapingAllPagesAllPagesVoidOnFailureSendableEscapingErrorErrorVoidVoidReceivedInvocations: [(onSuccess: (_ allPages: AllPages) -> Void, onFailure: (_ error: Error) -> Void)] = []
    public var callAsFunctionOnSuccessSendableEscapingAllPagesAllPagesVoidOnFailureSendableEscapingErrorErrorVoidVoidClosure: ((@Sendable @escaping (_ allPages: AllPages) -> Void, @Sendable @escaping (_ error: Error) -> Void) -> Void)?

    public func callAsFunction(onSuccess: @Sendable @escaping (_ allPages: AllPages) -> Void, onFailure: @Sendable @escaping (_ error: Error) -> Void) {
        callAsFunctionOnSuccessSendableEscapingAllPagesAllPagesVoidOnFailureSendableEscapingErrorErrorVoidVoidCallsCount += 1
        callAsFunctionOnSuccessSendableEscapingAllPagesAllPagesVoidOnFailureSendableEscapingErrorErrorVoidVoidReceivedArguments = (onSuccess: onSuccess, onFailure: onFailure)
        callAsFunctionOnSuccessSendableEscapingAllPagesAllPagesVoidOnFailureSendableEscapingErrorErrorVoidVoidReceivedInvocations.append((onSuccess: onSuccess, onFailure: onFailure))
        callAsFunctionOnSuccessSendableEscapingAllPagesAllPagesVoidOnFailureSendableEscapingErrorErrorVoidVoidClosure?(onSuccess, onFailure)
    }


}

