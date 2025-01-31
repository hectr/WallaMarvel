// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Command: Scripts/generate_mocks.sh --target=Domain --import=DomainContracts

 @testable import Domain
 import DomainContracts

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























public class CharacterModelContainerStoreProtocolMock: CharacterModelContainerStoreProtocol {

    public init() {}



    //MARK: - add

    public var addPageCharacterModelContainerVoidCallsCount = 0
    public var addPageCharacterModelContainerVoidCalled: Bool {
        return addPageCharacterModelContainerVoidCallsCount > 0
    }
    public var addPageCharacterModelContainerVoidReceivedPage: (CharacterModelContainer)?
    public var addPageCharacterModelContainerVoidReceivedInvocations: [(CharacterModelContainer)] = []
    public var addPageCharacterModelContainerVoidClosure: ((CharacterModelContainer) -> Void)?

    public func add(page: CharacterModelContainer) {
        addPageCharacterModelContainerVoidCallsCount += 1
        addPageCharacterModelContainerVoidReceivedPage = page
        addPageCharacterModelContainerVoidReceivedInvocations.append(page)
        addPageCharacterModelContainerVoidClosure?(page)
    }

    //MARK: - get

    public var getHeroIdIntCharacterModelCallsCount = 0
    public var getHeroIdIntCharacterModelCalled: Bool {
        return getHeroIdIntCharacterModelCallsCount > 0
    }
    public var getHeroIdIntCharacterModelReceivedId: (Int)?
    public var getHeroIdIntCharacterModelReceivedInvocations: [(Int)] = []
    public var getHeroIdIntCharacterModelReturnValue: CharacterModel?
    public var getHeroIdIntCharacterModelClosure: ((Int) -> CharacterModel?)?

    public func get(hero id: Int) -> CharacterModel? {
        getHeroIdIntCharacterModelCallsCount += 1
        getHeroIdIntCharacterModelReceivedId = id
        getHeroIdIntCharacterModelReceivedInvocations.append(id)
        if let getHeroIdIntCharacterModelClosure = getHeroIdIntCharacterModelClosure {
            return getHeroIdIntCharacterModelClosure(id)
        } else {
            return getHeroIdIntCharacterModelReturnValue
        }
    }


}
public class MarvelRepositoryProtocolMock: MarvelRepositoryProtocol {

    public init() {}



    //MARK: - fetchHeroes

    public var fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidCallsCount = 0
    public var fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidCalled: Bool {
        return fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidCallsCount > 0
    }
    public var fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidReceivedCompletion: (((CharacterModelContainer) -> Void))?
    public var fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidReceivedInvocations: [(((CharacterModelContainer) -> Void))] = []
    public var fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidClosure: ((@Sendable @escaping (CharacterModelContainer) -> Void) -> Void)?

    public func fetchHeroes(completion: @Sendable @escaping (CharacterModelContainer) -> Void) {
        fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidCallsCount += 1
        fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidReceivedCompletion = completion
        fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidReceivedInvocations.append(completion)
        fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidClosure?(completion)
    }

    //MARK: - getHero

    public var getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidCallsCount = 0
    public var getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidCalled: Bool {
        return getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidCallsCount > 0
    }
    public var getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidReceivedArguments: (heroId: Int, completion: (CharacterModel?) -> Void)?
    public var getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidReceivedInvocations: [(heroId: Int, completion: (CharacterModel?) -> Void)] = []
    public var getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidClosure: ((Int, @Sendable @escaping (CharacterModel?) -> Void) -> Void)?

    public func getHero(heroId: Int, completion: @Sendable @escaping (CharacterModel?) -> Void) {
        getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidCallsCount += 1
        getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidReceivedArguments = (heroId: heroId, completion: completion)
        getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidReceivedInvocations.append((heroId: heroId, completion: completion))
        getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidClosure?(heroId, completion)
    }


}

