import Foundation

extension URL
{
    init(_ endpoint: Endpoint) throws
    {
        self = try URLBuilder(baseUrl: endpoint.baseUrl)
            .add(parameters: endpoint.query)
            .add(path: endpoint.path)
            .build()
    }
}
