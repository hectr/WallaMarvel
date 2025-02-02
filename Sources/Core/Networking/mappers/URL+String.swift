import Foundation

extension URL
{
    init(_ urlString: String) throws
    {
        guard let url = URL(string: urlString) else {
            throw Failure.invalidUrl(urlString)
        }
        self = url
    }
}
