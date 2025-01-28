import SwiftUI

struct HeroDetailBackgroundView: View
{
    let from: Color
    let to: Color

    init(from: Color = .gray, to: Color = .black)
    {
        self.from = from
        self.to = to
    }

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
