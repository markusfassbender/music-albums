# Music Albums

Example app to show find and store music albums using the [Last.fm API](https://www.last.fm/api/intro).

## Setup

### Pods

It is required to run `pod install` first, because the pods themselves are not included in the repository.

### Keys

The NetworkService build target requires an API key to access the Last.fm API.

Duplicate `./music-albums⁩/NetworkService⁩/Keys_example.plist` and name it `Keys.plist` (git ignores this file). Set your private Last.fm API key in the new file. 
