import SwiftUI

struct BackdropView: View {
    var imageURL: URL?
    var placeholder: Image = Image("placeholder-backdrop")
    
    var body: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            if imageURL != nil {
                ProgressView()
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    NavigationView {
        BackdropView()
    }
    .accentColor(.yellow)
    .preferredColorScheme(.dark)
}
