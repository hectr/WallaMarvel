@testable import HeroDetail
import SnapshotTesting
import SwiftUI
import Testing
import UIKit

@Suite(.snapshots(record: .missing, diffTool: .ksdiff)) @MainActor
final class HeroDetailViewSnapshotTests
{
    @Test
    func `default`()
    {
        assertSnapshot(of: HeroDetailView_Default_Previews.self, layout: .device(config: .iPhoneSe))
    }

    @Test
    func expanded()
    {
        assertSnapshot(of: HeroDetailView_Expanded_Previews.self, layout: .device(config: .iPhoneSe))
    }

    @Test
    func liked()
    {
        assertSnapshot(of: HeroDetailView_Liked_Previews.self, layout: .device(config: .iPhoneSe))
    }

    @Test
    func noDescription()
    {
        assertSnapshot(of: HeroDetailView_NoDescription_Previews.self, layout: .device(config: .iPhoneSe))
    }
}
