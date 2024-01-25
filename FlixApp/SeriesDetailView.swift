//
//  ShowDetailView.swift
//  Flix
//
//  Created by alex on 1/11/24.
//

import SwiftUI
import FlixCore

struct SeriesDetailView: View {
    var model: FlixSeriesModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let seriesDetails = model.series {
                StretchableHeader {
                    BackdropView(imageURL: seriesDetails.backdropURL)
                }
                .overlay(alignment: .bottomLeading) {
                    TitleView(name: seriesDetails.name, genres: seriesDetails.genresString, numberOfSeasons: seriesDetails.numberOfSeasons, numberOfEpisodes: seriesDetails.numberOfEpisodes, lastAirDate: seriesDetails.lastAirDate)
                        .padding()
                }
                VStack(alignment: .leading, spacing: 16) {
                    Text(seriesDetails.overview)
                        .font(.system(size: 13))
                        .lineSpacing(4)
                    
                    if let season = model.selectedSeason {
                        if seriesDetails.numberOfSeasons > 1 {
                            Menu {
                                ForEach(seriesDetails.seasons) { season in
                                    Button(season.name, action: { selectSeason(season: season) })
                                }
                            } label: {
                                Text(season.name)
                                    .foregroundStyle(.yellow)
                                    .padding(.vertical, 8)
                            }.preferredColorScheme(.dark)
                        } else {
                            Text(season.name)
                                .foregroundStyle(.white)
                        }
                        EpisodeList(episodes: model.episodes)
                    }
                }
                .padding()
                .foregroundColor(.white)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.black, ignoresSafeAreaEdges: .all)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .task {
            do {
                try await model.load()
            } catch {
                print(error)
            }
        }
        .onChange(of: model.selectedSeason) { _, _ in
            Task {
                try await model.loadSeason()
            }
        }
    }
    
    func selectSeason(season: Season) {
        self.model.selectedSeason = season
    }
}
    
#Preview {
    SeriesDetailView(model: FlixSeriesModel(client: .mock(), seriesId: 108978))
        .preferredColorScheme(.dark)
}

struct EpisodeList: View {
    var episodes: [Episode]
    var size: CGSize = CGSize(width: 100, height: 60)
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            ForEach(episodes) { episode in
                EpisodeRowView(name: episode.name, overview: episode.overview, runtime: episode.runtime) {
                    BackdropView(imageURL: episode.stillURL)
                    .frame(width: size.width, height: size.height)
                }
                .foregroundStyle(.white)
            }
        }
        
    }
}
