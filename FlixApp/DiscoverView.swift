//
//  HomeView.swift
//  Flix
//
//  Created by alex on 1/15/24.
//

import SwiftUI
import FlixCore



struct DiscoverView: View {
    var model: FlixDiscoverModel
    
    enum Destination: Hashable {
        case showDetails(Int)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let feature = model.feature {
                    StretchableHeader {
                        BackdropView(imageURL: feature.backdropURL)
                    }
                    .overlay(alignment: .bottomLeading) {
                        TitleView(name: feature.name, genres: feature.genresString, numberOfSeasons: feature.numberOfSeasons, numberOfEpisodes: feature.numberOfEpisodes, lastAirDate: feature.lastAirDate)
                            .padding()
                    }
                }
                VStack(alignment: .leading) {
                    Carousel(title: "Trending") {
                        ForEach(model.trending) { series in
                            NavigationLink(value: Destination.showDetails(series.id)) {
                                PosterView(name: series.name, posterURL: series.posterURL)
                            }
                        }
                    }
                    Carousel(title: "Popular") {
                        ForEach(model.popular) { series in
                            NavigationLink(value: Destination.showDetails(series.id)) {
                                PosterView(name: series.name, posterURL: series.posterURL)
                            }
                        }
                    }
                }
                .foregroundStyle(.primary)
                .padding(.vertical, 16)
            }
            .navigationDestination(for: Destination.self) { destination in
                if case .showDetails(let seriesId) = destination {
                    SeriesDetailView(model: model.seriesModel(for: seriesId))
                }
            }
            .background(.black, ignoresSafeAreaEdges: .all)
            .ignoresSafeArea(edges:[.top])
        }
        .task {
            do {
                try await model.load()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    DiscoverView(model: FlixDiscoverModel(client: .mock()))
        .preferredColorScheme(.dark)
        .accentColor(.yellow)
        .tint(.accentColor)
}
