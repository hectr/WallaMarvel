@testable import HeroDetail
import SnapshotTesting
import SwiftUI
import Testing
import UIKit

@Suite(.snapshots(record: .missing, diffTool: .ksdiff)) @MainActor
final class HeroDetailHeaderViewSnapshotTests
{
    @Test
    func preview()
    {
        assertSnapshot(of: HeroDetailHeaderView_Previews.self, layout: .device(config: .iPhoneSe))
    }
}
