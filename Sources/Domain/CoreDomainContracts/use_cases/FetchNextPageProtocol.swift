/// This protocol is @MainActor-isolated because of a Swift bug. See `MarvelRepository` for more details.
///
/// sourcery: AutoMockable
@MainActor
public protocol FetchNextPageProtocol
{
    typealias AllPages = [CharacterModelContainer]

    func callAsFunction(
        onSuccess: @escaping @Sendable (_ allPages: AllPages) -> Void,
        onFailure: @escaping @Sendable (_ error: Error) -> Void
    )
}
