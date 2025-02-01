/// sourcery: AutoMockable
public protocol GetHeroesProtocol
{
    func callAsFunction(completion: @escaping @Sendable (CharacterModelContainer) -> Void)
}
