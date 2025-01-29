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
        assertSnapshot(of: HeroDetailView_Default_Previews.self, size: .iPhone5)
    }

    @Test
    func expanded()
    {
        assertSnapshot(of: HeroDetailView_Expanded_Previews.self, size: .iPhone5)
    }

    @Test
    func liked()
    {
        assertSnapshot(of: HeroDetailView_Liked_Previews.self, size: .iPhone5)
    }
}
