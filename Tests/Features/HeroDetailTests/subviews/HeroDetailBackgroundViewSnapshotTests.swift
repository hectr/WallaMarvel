@testable import HeroDetail
import SnapshotTesting
import SwiftUI
import Testing
import UIKit

@Suite(.snapshots(record: .missing, diffTool: .ksdiff)) @MainActor
final class HeroDetailBackgroundViewSnapshotTests
{
    @Test
    func preview()
    {
        assertSnapshot(of: HeroDetailBackgroundView_Previews.self)
    }
}
