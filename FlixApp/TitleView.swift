import SwiftUI

struct TitleView: View {
    var name: String
    var genres: String
    var numberOfSeasons: Int
    var numberOfEpisodes: Int
    var lastAirDate: Date?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(name)
                .font(.title2.bold())
            Text(genres)
                .font(.caption)
                .foregroundStyle(.secondary)
            HStack {
                Text("^[\(numberOfSeasons) Season](inflect: true)")
                Image(systemName: "diamond.fill")
                    .font(.system(size: 6))
                    .foregroundStyle(Color.accentColor)
                Text("^[\(numberOfEpisodes) Episode](inflect: true)")
                if let lastAirDate {
                    Image(systemName: "diamond.fill")
                        .font(.system(size: 6))
                        .foregroundStyle(Color.accentColor)
                    Text(lastAirDate, style: .date)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    TitleView(name: "Reacher", genres: "Action & Adventure, Crime, Drama", numberOfSeasons: 2, numberOfEpisodes: 16, lastAirDate: Date())
        .accentColor(.yellow)
        .padding()
        .preferredColorScheme(.dark)
}
