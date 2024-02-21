import SwiftUI

struct PosterView: View {
    var name: String = ""
    var posterURL: URL? = nil
    var size: CGSize = CGSize(width: 100, height: 150)
    var placeholder: Image = Image("placeholder-poster")
    
    var body: some View {
        VStack {
            AsyncImage(url: posterURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            } placeholder: {
                if posterURL != nil {
                    ProgressView()
                } else {
                    placeholder
                        .resizable()
                        .aspectRatio(0.667, contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            }
            .frame(width: size.width, height: size.height)
            Text(name)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .lineLimit(3, reservesSpace: true)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.primary)
                .frame(width: size.width)
        }
    }
}

struct Rating: View {
    private let progress: Double
    
    init(progress: Double) {
        self.progress = progress
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 2))
            
            Circle()
                .trim(from: 0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: progress)
            Text(Int(progress * 100), format: .percent)
                .font(.system(size: 9).bold())
        }
        .padding(4)
        .background(Circle().fill(.white))
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack(spacing:8) {
            PosterView(name: "One")
            PosterView(name: "Two")
            PosterView(name: "Three")
            PosterView(name: "Four")
        }
    }
    .preferredColorScheme(.dark)
    
}
