import Foundation
import Observation

@Observable
public class FlixSeriesModel {
    private var seriesId: Int
    public var client: MovieDB
    public var series: SeriesDetails?
    public var selectedSeason: Season?
    public var episodes: [Episode] = []
    
    public init(client: MovieDB, seriesId: Int) {
        self.client = client
        self.seriesId = seriesId
    }
    
    public func load() async throws {
        self.series = try await client.series(seriesId)
        self.selectedSeason = series?.seasons.last
    }
    
    public func loadSeason()async throws  {
        guard let seriesId = series?.id, let seasonNumber = selectedSeason?.seasonNumber else { return }
        episodes = try await client.season(seriesId, seasonNumber).episodes
    }
}
