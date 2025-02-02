import Foundation

extension URLComponents
{
    init(_ url: URL, resolvingAgainstBaseURL flag: Bool = true) throws
    {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: flag) else {
            throw Failure.malformedInputURL(url)
        }
        self = components
    }
}
