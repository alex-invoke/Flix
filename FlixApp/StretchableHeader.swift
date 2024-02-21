import SwiftUI

struct StretchableHeader<Content: View>: View {
    var initialHeaderHeight: CGFloat = UIScreen.main.bounds.height * 0.5
    var content: () -> Content
    
    var body: some View {
        GeometryReader(content: { geometry in
            
            let minY = max(geometry.frame(in: .global).minY, 0)
            let scale = (initialHeaderHeight + minY) / initialHeaderHeight
            let offset = minY > 0 ? -minY : 0
            
            content()
                .aspectRatio(2, contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: initialHeaderHeight * scale)
                .clipShape(Rectangle())
                .overlay(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
                .offset(y: offset)
        })
        .frame(height: initialHeaderHeight)
        .ignoresSafeArea(edges:.top)

    }
}

#Preview {
    ScrollView {
        StretchableHeader {
            Image("backdrop")
                .resizable()
        }
    }
    .background(.black, ignoresSafeAreaEdges: .all)
}
