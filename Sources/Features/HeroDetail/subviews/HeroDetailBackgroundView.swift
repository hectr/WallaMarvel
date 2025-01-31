import SwiftUI

struct HeroDetailBackgroundView: View
{
    // MARK: Depenedencies

    let from: Color
    let to: Color

    // MARK: Lifecycle

    init(from: Color = .gray, to: Color = .black)
    {
        self.from = from
        self.to = to
    }

    // MARK: Content

    var body: some View
    {
        LinearGradient(
            colors: [from, to ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

// MARK: - Preview

struct HeroDetailBackgroundView_Previews: PreviewProvider
{
    static var previews: some View
    {
        HeroDetailBackgroundView()
    }
}
