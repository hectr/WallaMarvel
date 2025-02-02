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


    var nextOffset: Int {
        get { return underlyingNextOffset }
        set(value) { underlyingNextOffset = value }
    }
    var underlyingNextOffset: (Int)!
    var pages: [CharacterModelContainer] = []
    var lockedOffsets: [Int] = []


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

    var fetchHeroesLimitIntOffsetIntOnSuccessSendableEscapingCharacterDataContainerVoidOnFailureSendableEscapingErrorVoidVoidCallsCount = 0
    var fetchHeroesLimitIntOffsetIntOnSuccessSendableEscapingCharacterDataContainerVoidOnFailureSendableEscapingErrorVoidVoidCalled: Bool {
        return fetchHeroesLimitIntOffsetIntOnSuccessSendableEscapingCharacterDataContainerVoidOnFailureSendableEscapingErrorVoidVoidCallsCount > 0
    }
    var fetchHeroesLimitIntOffsetIntOnSuccessSendableEscapingCharacterDataContainerVoidOnFailureSendableEscapingErrorVoidVoidReceivedArguments: (limit: Int?, offset: Int?, onSuccess: (CharacterDataContainer) -> Void, onFailure: (Error) -> Void)?
    var fetchHeroesLimitIntOffsetIntOnSuccessSendableEscapingCharacterDataContainerVoidOnFailureSendableEscapingErrorVoidVoidReceivedInvocations: [(limit: Int?, offset: Int?, onSuccess: (CharacterDataContainer) -> Void, onFailure: (Error) -> Void)] = []
    var fetchHeroesLimitIntOffsetIntOnSuccessSendableEscapingCharacterDataContainerVoidOnFailureSendableEscapingErrorVoidVoidClosure: ((Int?, Int?, @Sendable @escaping (CharacterDataContainer) -> Void, @Sendable @escaping (Error) -> Void) -> Void)?

    func fetchHeroes(limit: Int?, offset: Int?, onSuccess: @Sendable @escaping (CharacterDataContainer) -> Void, onFailure: @Sendable @escaping (Error) -> Void) {
        fetchHeroesLimitIntOffsetIntOnSuccessSendableEscapingCharacterDataContainerVoidOnFailureSendableEscapingErrorVoidVoidCallsCount += 1
        fetchHeroesLimitIntOffsetIntOnSuccessSendableEscapingCharacterDataContainerVoidOnFailureSendableEscapingErrorVoidVoidReceivedArguments = (limit: limit, offset: offset, onSuccess: onSuccess, onFailure: onFailure)
        fetchHeroesLimitIntOffsetIntOnSuccessSendableEscapingCharacterDataContainerVoidOnFailureSendableEscapingErrorVoidVoidReceivedInvocations.append((limit: limit, offset: offset, onSuccess: onSuccess, onFailure: onFailure))
        fetchHeroesLimitIntOffsetIntOnSuccessSendableEscapingCharacterDataContainerVoidOnFailureSendableEscapingErrorVoidVoidClosure?(limit, offset, onSuccess, onFailure)
    }


}
public class MarvelRepositoryProtocolMock: MarvelRepositoryProtocol {

    public init() {}



    //MARK: - fetchHeroes

    public var fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidCallsCount = 0
    public var fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidCalled: Bool {
        return fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidCallsCount > 0
    }
    public var fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidReceivedArguments: (onSuccess: ([CharacterModelContainer]) -> Void, onFailure: (Error) -> Void)?
    public var fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidReceivedInvocations: [(onSuccess: ([CharacterModelContainer]) -> Void, onFailure: (Error) -> Void)] = []
    public var fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidClosure: ((@Sendable @escaping ([CharacterModelContainer]) -> Void, @Sendable @escaping (Error) -> Void) -> Void)?

    public func fetchHeroes(onSuccess: @Sendable @escaping ([CharacterModelContainer]) -> Void, onFailure: @Sendable @escaping (Error) -> Void) {
        fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidCallsCount += 1
        fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidReceivedArguments = (onSuccess: onSuccess, onFailure: onFailure)
        fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidReceivedInvocations.append((onSuccess: onSuccess, onFailure: onFailure))
        fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidClosure?(onSuccess, onFailure)
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

