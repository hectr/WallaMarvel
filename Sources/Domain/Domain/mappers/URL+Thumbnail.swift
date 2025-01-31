import DataContracts
import Foundation

extension URL
{
    public init?(_ data: Thumbnail)
    {
        self.init(string: data.path + "/portrait_small." + data.extension)
    }
}
