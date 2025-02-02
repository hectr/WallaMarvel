import Collections
import Foundation

final class URLBuilder
{
    private var components: URLComponents

    init(baseUrl: String) throws
    {
        let url = try URL(baseUrl)
        components = try URLComponents(url)
    }

    @discardableResult
    func add(path: String) throws -> URLBuilder
    {
        var url = try URL(components)
        url.appendPathComponent(path)
        components.path = url.path
        return self
    }

    @discardableResult
    func add(parameters: OrderedDictionary<String, CustomStringConvertible?>?) -> URLBuilder
    {
        guard let parameters else {
            return self
        }
        let queryItems: [URLQueryItem] = parameters.compactMap { parameter in
            guard let value = parameter.value else {
                return nil
            }
            return URLQueryItem(
                name: parameter.key,
                value: value.description
            )
        }
        return add(queryItems: queryItems)
    }

    @discardableResult
    func add(queryItems newQueryItems: [URLQueryItem]) -> URLBuilder
    {
        if let queryItems = components.queryItems {
            components.queryItems = queryItems + newQueryItems
        } else {
            components.queryItems = newQueryItems
        }
        return self
    }

    func build() throws -> URL
    {
        try URL(components)
    }
}
