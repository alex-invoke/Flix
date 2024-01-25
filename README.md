# Flix 

Flix is a simple iOS app for discovering popular and trending TV shows provided by the [The MovieDB API](https://developer.themoviedb.org/docs/getting-started). 

<img src="/screenshots/screenshot1.png" width="200">

<img src="/screenshots/screenshot2.png" width="200">

## Goals/Features

The purpose of Flix is to be used as a demo project to experience with common app architecture patterns and SwiftUI features.

-[x] MVVM app architecture using SwiftUI
-[x] Leverage local SPM packages to modularize the app
-[x] Modern network layer abstraction leveraging async/await
-[] SwiftLint
-[] Improve accessibility
-[] Improve test coverage

## API Token

Data is provided by [The MovieDB API](https://developer.themoviedb.org/docs/getting-started) and requires an API token to run. 

- Create a free [TMDB account](https://www.themoviedb.org/signup)
- [Request an API](https://www.themoviedb.org/settings/api) token under the account settings.
- In Xcode, edit the Add an environment variable called `MOVIEDB_API_TOKEN` 

![Configure Environment Variable](/screenshots/environment-variable.png)

## Requirements

Xcode 15+
iOS 17.0+
Swift 5.5+

## License

This project is licensed under the MIT License - see the LICENSE file for details.

### Acknowledgments

Flix would not have been possible without the following libraries and resources:

[The MovieDB API](https://developer.themoviedb.org/docs/getting-started)
