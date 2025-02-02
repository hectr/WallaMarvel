import Foundation

extension URL
{
    init(_ urlComponents: URLComponents) throws
    {
        guard let url = urlComponents.url else {
            throw Failure.malformedOutputURL(urlComponents)
        }

        self = url
    }
}
