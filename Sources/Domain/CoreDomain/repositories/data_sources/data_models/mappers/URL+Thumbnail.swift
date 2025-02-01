import Foundation

extension URL
{
    init?(_ data: Thumbnail)
    {
        self.init(string: data.path + "/portrait_small." + data.extension)
    }
}
