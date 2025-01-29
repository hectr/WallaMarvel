@testable import HeroDetail
import SnapshotTesting
import SwiftUI
import Testing
import UIKit

@Suite(.snapshots(record: .missing, diffTool: .ksdiff)) @MainActor
final class HeroDetailViewSnapshotTests
{
    @Test
    func preview()
    {
        assertSnapshot(of: HeroDetailView_Previews.self, size: .iPhone5)
    }
}
