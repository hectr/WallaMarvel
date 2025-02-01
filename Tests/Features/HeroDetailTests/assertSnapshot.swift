import SnapshotTesting
import SwiftUI
import UIKit

@MainActor
func assertSnapshot<Value: PreviewProvider>(
    of value: @autoclosure () throws -> Value.Type,
    layout optionalLayout: SwiftUISnapshotLayout? = nil,
    record recording: Bool? = nil,
    timeout: TimeInterval = 5,
    fileID: StaticString = #fileID,
    file filePath: StaticString = #filePath,
    testName: String = #function,
    line: UInt = #line,
    column: UInt = #column
)
{
    let name = "\(UIDevice.current.name).\(UIDevice.current.systemVersion)"
    do {
        let previews = try value().previews
        let layout: SwiftUISnapshotLayout
        if let optionalLayout {
            layout = optionalLayout
        } else {
            let view = UIHostingController(rootView: previews).view
            let size = view!.intrinsicContentSize
            layout = .fixed(width: size.width, height: size.height)
        }
        SnapshotTesting.assertSnapshot(
            of: previews,
            as: .image(
                precision: 0.99,
                perceptualPrecision: 0.99,
                layout: layout
            ),
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
