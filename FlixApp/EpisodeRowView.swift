//
//  EpisodeView.swift
//  Flix
//
//  Created by alex on 1/12/24.
//

import SwiftUI

struct EpisodeRowView<Cover: View>: View {
    var name: String
    var overview: String
    var runtime: Int?
    var cover: () -> Cover
    var body: some View {
        HStack(alignment: .top) {
            cover()
                .aspectRatio(1.66, contentMode: .fill)
                .frame(width: 100, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 14).bold())
                if let runtime {
                    Text(Duration.seconds(runtime * 60), format: .units(allowed: [.hours, .minutes]))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

#Preview {
    EpisodeRowView(name: "Episode 1", overview: "Overview text", runtime: 23) {
        Image("backdrop")
            .resizable()
    }
}
