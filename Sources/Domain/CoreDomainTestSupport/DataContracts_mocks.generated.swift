// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Command: Scripts/generate_mocks.sh --target=CoreDomain --import=CoreDomainContracts

@testable import CoreDomain
import CoreDomainContracts
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























public class MarvelRemoteDataSourceProtocolMock: MarvelRemoteDataSourceProtocol {

    public init() {}



    //MARK: - fetchHeroes

    public var fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidCallsCount = 0
    public var fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidCalled: Bool {
        return fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidCallsCount > 0
    }
    public var fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidReceivedCompletion: (((CharacterDataContainer) -> Void))?
    public var fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidReceivedInvocations: [(((CharacterDataContainer) -> Void))] = []
    public var fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidClosure: ((@Sendable @escaping (CharacterDataContainer) -> Void) -> Void)?

    public func fetchHeroes(completion: @Sendable @escaping (CharacterDataContainer) -> Void) {
        fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidCallsCount += 1
        fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidReceivedCompletion = completion
        fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidReceivedInvocations.append(completion)
        fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidClosure?(completion)
    }


}

