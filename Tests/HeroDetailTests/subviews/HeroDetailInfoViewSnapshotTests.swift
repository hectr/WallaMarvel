@testable import HeroDetail
import SnapshotTesting
import SwiftUI
import Testing
import UIKit

@Suite(.snapshots(record: .missing, diffTool: .ksdiff)) @MainActor
final class HeroDetailInfoViewSnapshotTests
{
    @Test
    func preview()
    {
        assertSnapshot(of: HeroDetailInfoView_Previews.self, size: .iPhone1)
    }
}
