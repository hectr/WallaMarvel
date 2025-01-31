@testable import HeroDetail
import SnapshotTesting
import SwiftUI
import Testing
import UIKit

@Suite(.snapshots(record: .missing, diffTool: .ksdiff)) @MainActor
final class FirstAppearSnapshotTests
{
    @Test
    func preview()
    {
        assertSnapshot(of: FirstAppear_Previews.self)
    }
}
