public protocol GetHeroesProtocol
{
    func callAsFunction(completionBlock: @escaping @Sendable (CharacterModelContainer) -> Void)
}
