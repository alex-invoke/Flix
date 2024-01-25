//
//  File.swift
//  
//
//  Created by alex on 1/23/24.
//

import Foundation
import Observation

@Observable
public class FlixDiscoverModel {
    public var client: MovieDB
    public var popular: [Series] = []
    public var trending: [Series] = []
    public var feature: SeriesDetails?
    public var series: SeriesDetails?
    
    public init(client: MovieDB) {
        self.client = client
    }
    
    public func load() async throws {
        self.trending = try await client.trending(.week)
        if let featureID = trending.randomElement()?.id {
            self.feature = try await client.series(featureID)
        }
        self.popular = try await client.popular(.week)
    }
    
    public func seriesModel(for seriesId: Int) -> FlixSeriesModel {
        return FlixSeriesModel(client: client, seriesId: seriesId)
    }
}



