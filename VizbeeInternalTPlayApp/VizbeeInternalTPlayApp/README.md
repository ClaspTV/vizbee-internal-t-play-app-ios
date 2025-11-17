# T-Mobile Play App

A SwiftUI-based iOS application that displays a list of videos from various streaming providers (Plex, TBS, TNT) and integrates with the VizbeeTPlay SDK for casting functionality.

## Features

- **Video List Display**: Shows a scrollable list of movies and TV shows with thumbnails, titles, and provider information
- **T-Mobile Branding**: Custom navigation bar with T-Mobile Play logo
- **Cast Integration**: Cast button in the navigation bar using VizbeeTPlay SDK
- **Video Playback**: Tap "Watch Free" to start video playback through VizbeeTPlay SDK
- **Dark Theme**: Modern dark UI matching T-Mobile Play design

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+
- VizbeeTPlay SDK (VizbeeKit framework)

## Setup Instructions

### 1. Add VizbeeTPlay Framework

You need to add the VizbeeTPlay framework to your project:

1. Download or obtain the VizbeeKit.xcframework
2. In Xcode, go to your target's **General** tab
3. Under **Frameworks, Libraries, and Embedded Content**, click the **+** button
4. Add the VizbeeKit.xcframework
5. Make sure it's set to **Embed & Sign**

### 2. Configure App ID

Open `AppDelegate.swift` and replace the placeholder with your actual Vizbee App ID:

```swift
// Replace with your actual Vizbee App ID
let appId = "YOUR_VIZBEE_APP_ID"
```

Also configure the supported apps mapping:

```swift
options.supportedApps = [
    "plex": "your_plex_tv_app_id",
    "tbs": "your_tbs_tv_app_id",
    "tnt": "your_tnt_tv_app_id"
]
```

### 3. Add Required Permissions

Add these keys to your `Info.plist`:

```xml
<key>NSLocalNetworkUsageDescription</key>
<string>This app uses the local network to discover and connect to casting devices on your network.</string>

<key>NSBonjourServices</key>
<array>
    <string>_vizbee._tcp</string>
</array>
```

## Project Structure

```
TMobilePlayApp/
├── TMobilePlayApp.swift          # Main app entry point
├── AppDelegate.swift              # SDK initialization
├── Models/
│   └── Video.swift                # Video data model
├── Data/
│   └── VideoRepository.swift     # Video data source
├── ViewModels/
│   └── VideoListViewModel.swift  # Video list business logic
├── Views/
│   ├── ContentView.swift         # Main screen
│   └── VideoRowView.swift        # Video item component
└── Assets.xcassets/
    └── t_mobile_play_logo.imageset/
```

## How It Works

### SDK Initialization

The VizbeeTPlay SDK is initialized in `AppDelegate.swift` when the app launches:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions...) -> Bool {
    let appId = "YOUR_VIZBEE_APP_ID"
    let options = VTPOptions()
    options.debugMode = true
    
    VizbeeTPlay.initialize(appId: appId, options: options)
    return true
}
```

### Video Playback

When a user taps "Watch Free", the app:

1. Creates a `VTPVideoInfo` object with the video details
2. Calls `VizbeeTPlay.shared.startVideo(in:videoInfo:)`
3. The SDK handles device selection and playback

```swift
func playVideo(_ video: Video, in viewController: UIViewController) {
    let videoInfo = VTPVideoInfo(
        tvDeepLinkUrl: video.id,
        mobileDeepLinkUrl: video.id,
        title: video.title,
        subtitle: video.subtitle,
        imageUrl: video.thumbnailUrl,
        isLive: false
    )
    
    let result = await VizbeeTPlay.shared.startVideo(
        in: viewController,
        videoInfo: videoInfo
    )
}
```

### Cast Button

The cast button is displayed in the navigation bar using:

```swift
ToolbarItem(placement: .navigationBarTrailing) {
    VTPCastButton.SwiftUIView(size: CGSize(width: 24, height: 24))
}
```

## Video Data

Videos are stored in `VideoRepository.swift` and include content from:
- **Plex**: Movies and TV shows
- **TBS**: TV shows and movies
- **TNT**: TV shows and movies

Each video includes:
- Deep link URL (used as ID)
- Title
- Subtitle (provider and content type)
- Thumbnail URL
- Content type (movie or TV show)

## Customization

### UI Configuration

You can customize the VizbeeTPlay UI in `AppDelegate.swift`:

```swift
let uiConfig = VZBUIConfig()
// Customize colors, fonts, etc.
options.uiConfiguration = uiConfig
```

### Video List

To add or modify videos, edit `VideoRepository.swift`:

```swift
Video(
    id: "https://your-deep-link-url",
    title: "Your Video Title",
    subtitle: "Provider • Type",
    thumbnailUrl: "https://thumbnail-url",
    contentType: .movie
)
```

### Styling

Colors and styling can be adjusted in:
- `VideoRowView.swift`: Video item styling
- `ContentView.swift`: Main screen layout and colors

## Troubleshooting

### Cast Button Not Appearing
- Ensure VizbeeKit framework is properly linked
- Check that SDK initialization completes successfully
- Verify network permissions in Info.plist

### Video Playback Fails
- Verify your Vizbee App ID is correct
- Check that deep link URLs are valid
- Ensure device discovery is working

### Debug Logging
Enable debug mode in AppDelegate:
```swift
options.debugMode = true
```

## Support

For VizbeeTPlay SDK issues, refer to the Vizbee documentation or contact Vizbee support.

## License

Copyright © Vizbee. All rights reserved.
