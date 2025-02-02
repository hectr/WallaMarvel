import Foundation

extension URLRequest
{
    init(_ endpoint: Endpoint) throws
    {
        let url = try URL(endpoint)
        self = URLRequest(url: url)
        self.httpMethod = endpoint.method.verb
    }
}
