import Kingfisher
import LeanRedux
import SwiftUI

struct RemoteImagePlaceholderView: View
{
    // MARK: Dependencies

    private let progress: Progress

    // MARK: Content

    var body: some View
    {
        image
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
    }

    private var image: Image {
        if progress.completedUnitCount == 0, progress.totalUnitCount == 0 {
            Image(systemName: "icloud.slash")
        } else {
            Image(systemName: "photo.fill")
        }
    }

    // MARK: Lifecycle

    init(progress: Progress) {
        self.progress = progress
    }
}

// MARK: - Preview

struct RemoteImagePlaceholderView_Previews: PreviewProvider
{
    static var previews: some View
    {
        RemoteImagePlaceholderView(progress: Progress(totalUnitCount: 1))
            .previewDisplayName("Default")

        RemoteImagePlaceholderView(
            progress: {
                let progress = Progress(totalUnitCount: 0)
                progress.completedUnitCount = 0
                return progress
            }()
        )
        .previewDisplayName("Error")
    }
}
