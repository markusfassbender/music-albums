# music-albums

Example app to show some functionalities of the [Last.fm API](https://www.last.fm/api/intro).

## Setup

### Pods

It is required to run `pod install` first, because the pods themselves are not included in the repository.

### API Keys

The NetworkService build target requires an API Key to access the Last.fm API to be able to load data.

The file must be at the path `./music-albums⁩/NetworkService⁩/Keys.plist` in this format:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>APIKey</key>
	<string>my_private_key</string>
</dict>
</plist>
```

## Licenses

### Icons8
This project uses Icons from Icons8 https://icons8.com .
