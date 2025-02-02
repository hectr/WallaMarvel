/// This protocol is @MainActor-isolated because of a Swift bug. See `MarvelRepository` for more details.
/// 
@MainActor
public protocol GetHeroProtocol
{
    func callAsFunction(heroId: Int, completion: @escaping @Sendable (CharacterModel?) -> Void)
}
