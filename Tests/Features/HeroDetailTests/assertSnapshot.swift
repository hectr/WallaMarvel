import SnapshotTesting
import SwiftUI
import UIKit

/// Some predefined sizes for snapshots.
/// A real implementation might need more control over the size, like flexible width or height.
enum SnapshotSize
{
    case intrinsicContentSize
    case iPhone1
    case iPhone5
    case iPhone6

    /// Sizes taken from [iOS Resolution](https://www.ios-resolution.com/).
    @MainActor
    func size(for view: UIView) -> CGSize
    {
        let size: CGSize
        switch self {
        case .intrinsicContentSize:
            size = view.intrinsicContentSize
        case .iPhone1:
            size = CGSize(width: 320, height: 480)
        case .iPhone5:
            size = CGSize(width: 320, height: 568)
        case .iPhone6:
            size = CGSize(width: 375, height: 667)
        }
        return size
    }
}

@MainActor
func assertSnapshot<Value: PreviewProvider>(
    of value: @autoclosure () throws -> Value.Type,
    size snapshotSize: SnapshotSize? = .intrinsicContentSize,
    named name: String? = nil,
    record recording: Bool? = nil,
    timeout: TimeInterval = 5,
    fileID: StaticString = #fileID,
    file filePath: StaticString = #filePath,
    testName: String = #function,
    line: UInt = #line,
    column: UInt = #column
)
{
    do {
        let view: UIView = try UIHostingController(rootView: value().previews).view
        SnapshotTesting.assertSnapshot(
            of: view,
            as: .image(size: snapshotSize?.size(for: view)),
            named: name,
            record: recording,
            timeout: timeout,
            fileID: fileID,
            file: filePath,
            testName: testName,
            line: line,
            column: column
        )
    } catch {
        try SnapshotTesting.assertSnapshot(
            of: { () throws -> UIView in throw error }(),
            as: .image(size: .zero),
            named: name,
            record: recording,
            timeout: 0,
            fileID: fileID,
            file: filePath,
            testName: testName,
            line: line,
            column: column
        )
    }

}
