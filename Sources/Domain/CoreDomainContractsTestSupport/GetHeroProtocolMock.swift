import CoreDomainContracts

public class GetHeroProtocolMock: GetHeroProtocol
{
    public init()
    {}

    //MARK: - callAsFunction

    public var callAsFunctionCallsCount = 0
    public var callAsFunctionCalled: Bool {
        return callAsFunctionCallsCount > 0
    }
    public var callAsFunctionReceivedArguments: (heroId: Int, completion: (CharacterModel?) -> Void)?
    public var callAsFunctionReceivedInvocations: [(heroId: Int, completion: (CharacterModel?) -> Void)] = []
    public var callAsFunctionClosure: (@Sendable (Int, @Sendable @escaping (CharacterModel?) -> Void) async -> Void)?

    public func callAsFunction(heroId: Int, completion: @Sendable @escaping (CharacterModel?) -> Void)
    {
        callAsFunctionCallsCount += 1
        callAsFunctionReceivedArguments = (heroId: heroId, completion: completion)
        callAsFunctionReceivedInvocations.append((heroId: heroId, completion: completion))
        let closure = callAsFunctionClosure
        Task {
            await closure?(heroId, completion)
        }
    }
}
