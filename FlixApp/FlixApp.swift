import SwiftUI
import FlixCore

@main
struct FlixApp: App {
    let discoverModel = FlixDiscoverModel(client: MovieDB.live(token: apiToken))
    
    var body: some Scene {
        WindowGroup {
            DiscoverView(model: discoverModel)
                .preferredColorScheme(.dark)
                .accentColor(.yellow)
                .tint(.yellow)
        }
    }
    
    /**
     Add "MOVIEDB_API_TOKEN" environment variable for the run action
     */
    
    static var apiToken: String {
        guard let token = ProcessInfo.processInfo.environment["MOVIEDB_API_TOKEN"] else {            fatalError("Expected environment variable for \"MOVIEDB_API_TOKEN\". See https://developer.apple.com/documentation/xcode/customizing-the-build-schemes-for-a-project#Specify-launch-arguments-and-environment-variables")
        }
        return token
    }
}
