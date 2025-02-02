import Networking
import Collections

struct CharactersEndpoint: Endpoint
{
    // MARK: Dependencies

    let hash: String
    let limit: Int?
    let nameStartsWith: String?
    let offset: Int?
    let publicKey: String
    let timestamp: Int

    // MARK: Lifecycle

    init(
        hash: String,
        limit: Int? = nil,
        nameStartsWith: String? = nil,
        offset: Int? = nil,
        publicKey: String,
        timestamp: Int
    ) {
        self.hash = hash
        self.limit = limit
        self.nameStartsWith = nameStartsWith
        self.offset = offset
        self.publicKey = publicKey
        self.timestamp = timestamp
    }

    // MARK: Endpoint

    let baseUrl = "https://gateway.marvel.com:443"
    let path = "v1/public/characters"

    var query: OrderedDictionary<String, CustomStringConvertible?>
    {[
        "apikey": publicKey,
        "hash": hash,
        "limit": limit,
        "offset": offset,
        "nameStartsWith": nameStartsWith,
        "ts": timestamp
    ]}
}
