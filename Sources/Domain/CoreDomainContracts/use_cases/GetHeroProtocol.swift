public protocol GetHeroProtocol
{
    func callAsFunction(heroId: Int, completion: @escaping @Sendable (CharacterModel?) -> Void)
}
