// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Command: Scripts/generate_mocks.sh --target=CoreDomain --sources-path=Sources/Domain --import=CoreDomainContracts

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
























class CharacterModelContainerStoreProtocolMock: CharacterModelContainerStoreProtocol {




    //MARK: - add

    var addPageCharacterModelContainerVoidCallsCount = 0
    var addPageCharacterModelContainerVoidCalled: Bool {
        return addPageCharacterModelContainerVoidCallsCount > 0
    }
    var addPageCharacterModelContainerVoidReceivedPage: (CharacterModelContainer)?
    var addPageCharacterModelContainerVoidReceivedInvocations: [(CharacterModelContainer)] = []
    var addPageCharacterModelContainerVoidClosure: ((CharacterModelContainer) -> Void)?

    func add(page: CharacterModelContainer) {
        addPageCharacterModelContainerVoidCallsCount += 1
        addPageCharacterModelContainerVoidReceivedPage = page
        addPageCharacterModelContainerVoidReceivedInvocations.append(page)
        addPageCharacterModelContainerVoidClosure?(page)
    }

    //MARK: - get

    var getHeroIdIntCharacterModelCallsCount = 0
    var getHeroIdIntCharacterModelCalled: Bool {
        return getHeroIdIntCharacterModelCallsCount > 0
    }
    var getHeroIdIntCharacterModelReceivedId: (Int)?
    var getHeroIdIntCharacterModelReceivedInvocations: [(Int)] = []
    var getHeroIdIntCharacterModelReturnValue: CharacterModel?
    var getHeroIdIntCharacterModelClosure: ((Int) -> CharacterModel?)?

    func get(hero id: Int) -> CharacterModel? {
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
class MarvelRemoteDataSourceProtocolMock: MarvelRemoteDataSourceProtocol {




    //MARK: - fetchHeroes

    var fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidCallsCount = 0
    var fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidCalled: Bool {
        return fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidCallsCount > 0
    }
    var fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidReceivedCompletion: (((CharacterDataContainer) -> Void))?
    var fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidReceivedInvocations: [(((CharacterDataContainer) -> Void))] = []
    var fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidClosure: ((@Sendable @escaping (CharacterDataContainer) -> Void) -> Void)?

    func fetchHeroes(completion: @Sendable @escaping (CharacterDataContainer) -> Void) {
        fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidCallsCount += 1
        fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidReceivedCompletion = completion
        fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidReceivedInvocations.append(completion)
        fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidClosure?(completion)
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

