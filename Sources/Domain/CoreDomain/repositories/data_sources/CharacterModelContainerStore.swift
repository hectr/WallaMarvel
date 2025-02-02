import CoreDomainContracts

/// `CharacterModelContainerStoreProtocol` is responsible for storing and retrieving `CharacterModelContainer` instances.
///
/// sourcery: AutoMockable
@Background
protocol CharacterModelContainerStoreProtocol: AnyObject, Sendable
{
    /// The offset of the next page that should be fetched.
    var nextOffset: Int { get }

    /// All pages that have been fetched.
    var pages: [CharacterModelContainer] { get }

    /// Page offsets that have been locked by a request.
    var lockedOffsets: [Int] { get set }

    /// Stores a page.
    func add(page: CharacterModelContainer)

    /// Retrieves a hero by its identifier.
    func get(hero id: Int) -> CharacterModel?
}

@Background
final class CharacterModelContainerStore: CharacterModelContainerStoreProtocol
{
    // MARK: State

    public private(set) var nextOffset: Int
    public private(set) var pages: [CharacterModelContainer]
    
    public var lockedOffsets: [Int]

    // MARK: Lifecycle

    nonisolated static func make() -> CharacterModelContainerStoreProtocol
    {
        CharacterModelContainerStore(
            pages: [],
            nextOffset: 0,
            lockedOffsets: []
        )
    }

    nonisolated init(
        pages: [CharacterModelContainer],
        nextOffset: Int,
        lockedOffsets: [Int]
    )
    {
        self.pages = pages
        self.nextOffset = nextOffset
        self.lockedOffsets = []
    }

    // MARK: Logic

    func add(page: CharacterModelContainer)
    {
        pages.append(page)
        nextOffset = page.offset + page.count

        if let index = lockedOffsets.firstIndex(of: nextOffset) {
            assert(page.count == 0, "nextOffset should be locked only when the received page is empty")
            // free the next offset if it was locked
            lockedOffsets.remove(at: index)
        }
    }

    func get(hero id: Int) -> CharacterModel?
    {
        for page in pages {
            if let match = (page.results.first { hero in hero.id == id }) {
                return match
            }
        }
        return nil
    }
}
