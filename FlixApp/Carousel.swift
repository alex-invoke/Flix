import SwiftUI

struct Carousel<Content: View>: View {
    var title: String
    var content: () -> Content
    
    init(title: String = "", @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline.bold())
                .padding(.leading, 16)
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 8, content: content)
                    .scrollTargetLayout()
            }
            .contentMargins(.leading, 16)
            .contentMargins(.trailing, 32)
            .contentMargins(.vertical, 0)
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}
#Preview {
    Carousel {
        Rectangle().fill(.red).frame(width: 80, height: 100)
        Rectangle().fill(.red).frame(width: 80, height: 100)
        Rectangle().fill(.red).frame(width: 80, height: 100)
        Rectangle().fill(.red).frame(width: 80, height: 100)
        Rectangle().fill(.red).frame(width: 80, height: 100)
        Rectangle().fill(.red).frame(width: 80, height: 100)
        Rectangle().fill(.red).frame(width: 80, height: 100)
    }
}
