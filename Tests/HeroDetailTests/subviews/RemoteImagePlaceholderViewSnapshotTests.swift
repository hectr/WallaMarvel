@testable import HeroDetail
import SnapshotTesting
import SwiftUI
import Testing
import UIKit

@Suite(.snapshots(record: .missing, diffTool: .ksdiff)) @MainActor
final class RemoteImagePlaceholderViewSnapshotTests
{
    @Test
    func preview()
    {
        assertSnapshot(of: RemoteImagePlaceholderView_Previews.self)
    }
}
