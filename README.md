# Vizbee T-Play iOS SDK Documentation

This guide provides instructions for integrating the Vizbee T-Play SDK into your iOS application.

## Setup

### Swift Package Manager

The Vizbee T-Play SDK is distributed via Swift Package Manager.

1.  In Xcode, go to **File > Add Packages...**
2.  Add the following package repositories:

    ```
    https://github.com/ClaspTV/vizbee-tplay-sdk
    https://github.com/ClaspTV/vizbee-ios-sdk
    https://github.com/ClaspTV/vizbee-homeos-sdk
    https://github.com/ClaspTV/google-cast-sdk-m1
    ```

3.  Set the dependency rules to the following versions (or later):
    *   `VizbeeTPlayKit`: `1.0.0`
    *   `VizbeeKit`: `6.8.4`
    *   `VizbeeHomeOSKit`: `1.0.3`
    *   `GoogleCastSDK`: `4.8.0`

## Configuration

### 1. Enable Multicast Networking

To allow the SDK to discover devices on the local network, you must request and enable the Multicast Networking entitlement for your app.

> Follow the instructions specified [here](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_networking_multicast) to use and verify the Multicast Networking Additional Capability.

In your app’s `.entitlements` file, add the `com.apple.developer.networking.multicast` key with a Boolean value of `true`:

```xml
<key>com.apple.developer.networking.multicast</key>
<true/>
```

### 2. Configure Info.plist for Network Access

To discover specific cast devices and explain local network usage to the user, add the following keys to your `Info.plist`:

*   **Bonjour Services (`NSBonjourServices`)**: This array declares the services your app will browse on the local network. Add the following strings to the array:
    *   `_googlecast._tcp` : for finding Chromecast devices
    *   `_viziocast._tcp` : for finding Vizio SmartCast devices
    *   `_amzn-wplay._tcp` : for finding and installing apps on FireTV devices

    ```xml
    <key>NSBonjourServices</key>
    <array>
        <string>_googlecast._tcp</string>
        <string>_viziocast._tcp</string>
        <string>_amzn-wplay._tcp</string>
    </array>
    ```

*   **Local Network Usage Description (`NSLocalNetworkUsageDescription`)**: This message is shown to the user when your app first attempts to access the local network.

    ```xml
    <key>NSLocalNetworkUsageDescription</key>
    <string>This app enables you to cast videos and automatically install and login to Roku, FireTV, SamsungTV and other streaming devices on your home network.</string>
    ```

## Integration Guide

The Vizbee T-Play SDK enables video casting in your app through three simple integration steps.

### Step 1: Initialize the SDK

Initialize the SDK once at app startup, typically in your `App` struct or `AppDelegate`. This enables device discovery and establishes the casting environment.

**Example:**
```swift
// In @main App struct
import SwiftUI
import VizbeeTPlayKit

@main
struct VizbeeInternalTPlayAppApp: App {

    init() {
        initVizbeeTPlay()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func initVizbeeTPlay() {
        let appId = "vzb2379701350"
        var options = VTPOptions()
        // Apply a custom UI theme. See Step 4 for details.
        options.uiConfiguration = TPlayStyle.darkTheme()
        VizbeeTPlay.initialize(appId: appId, options: options)
    }
}
```

### Step 2: Add Cast Button

Add the cast button to your UI. The button automatically updates its state to show casting availability and current connection status.

**Add to SwiftUI Toolbar:**
In your view's `.toolbar`, add the `VTPCastButton.SwiftUIView`.

```swift
// In your SwiftUI View
.toolbar {
    ToolbarItem(placement: .navigationBarTrailing) {
        VTPCastButton.SwiftUIView(size: CGSize(width: 24, height: 24))
            .frame(width: 24, height: 24)
    }
}
```
> For a complete example, see the implementation in `VizbeeInternalTPlayApp/Views/ContentView.swift`.

### Step 3: Start Video Playback

Implement video casting by calling `startVideo()` when a user wants to watch content. This presents a device picker if not already connected and handles the entire casting flow.

The `startVideo` function is an `async` method that returns a `VTPStartVideoResult`.

```swift
// In your ViewModel or wherever you handle user actions
@MainActor
func playVideo(_ video: Video, in viewController: UIViewController) {
    Task {
        // Create VTPVideoInfo from your video model
        let videoInfo = VTPVideoInfo(
            mobileDeepLinkUrl: video.mobileDeepLinkUrl,
            tvDeepLinkUrl: video.tvDeepLinkUrl,
            title: video.title,
            subtitle: video.subtitle,
            imageUrl: video.thumbnailUrl,
            isLive: video.isLive
        )

        // Call VizbeeTPlay SDK to start video
        let result = await VizbeeTPlay.shared.startVideo(
            in: viewController,
            videoInfo: videoInfo
        )

        // Handle the result
        switch result {
        case .success(let destination):
            print("✅ Video playback started successfully on \\(destination)")
            
        case .failure(let error):
            print("❌ Video playback failed: \\(error)")
            // Optionally update UI to show an error
            self.errorMessage = "Failed to start video: \\(error.localizedDescription)"
        @unknown default:
            break // Handle future cases
        }
    }
}
```
> For a complete example of how to manage state and call this method, see `VizbeeInternalTPlayApp/ViewModels/VideoListViewModel.swift`.

### Step 4: [Optional] Customizing UI

You can customize the appearance of the Vizbee SDK's UI to match your app's branding.

#### 1. Custom Cast Icons

To use your own cast icons, add the images to your project's `Assets.xcassets` catalog. The SDK automatically uses icons with specific names to reflect the various connection states (e.g., disconnected, connecting, connected).

> For a complete example of the required icon names and states, refer to the `Assets.xcassets` file in the `vizbee-internal-t-play-app-ios` sample project.

#### 2. Custom Theme

To customize the colors, fonts, and other visual elements of the Vizbee UI (like the device picker), copy the `TPlayStyle.swift` file from `VizbeeInternalTPlayApp/styles/TPlayStyle.swift` into your project. This file provides style dictionaries for dark and light themes that you can modify.

Then, pass your style configuration when initializing the SDK, as shown in Step 1.


## Analytics

The T-Play SDK provides comprehensive analytics events to track the user journey. To receive these events, implement the `VTPAnalyticsListener` protocol and register your class as a listener.

The sample app includes a singleton class, `AppAnalytics`, to demonstrate a clean and reusable way to handle these events. To integrate analytics:

1.  Copy the `Analytics/AppAnalytics.swift` file into your project.
2.  In your `App` initializer or `AppDelegate`, start the listener:

    ```swift
    AppAnalytics.shared.startListening()
    ```

### Example Implementation

Here is the full implementation from `Analytics/AppAnalytics.swift`:

```swift
import Foundation
import VizbeeTPlayKit
import VizbeeHomeOSKit
import os.log

/// A singleton class to handle Vizbee T-Play analytics events.
class AppAnalytics: VTPAnalyticsListener {

    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "AppAnalytics")

    /// The shared singleton instance.
    static let shared = AppAnalytics()

    /// Private initializer to enforce the singleton pattern.
    private init() {}

    /// Registers this instance to start receiving analytics events.
    func startListening() {
        VizbeeTPlay.shared.analyticsManager.addListener(self)
    }

    /// Unregisters this instance to stop receiving analytics events.
    func stopListening() {
        VizbeeTPlay.shared.analyticsManager.removeListener(self)
    }

    // MARK: - VTPAnalyticsListener

    func onEvent(_ event: VizbeeTPlayKit.VTPAnalyticsEvent) {
        Self.logger.info("Analytics Event: \(event)")

        switch event {
        case .deviceSelectionDialogShown(let devices):
            Self.logger.info("Device selection dialog shown with \(devices.count) devices.")

        case .deviceSelectionDialogUpdated(let updatedDevices):
            Self.logger.info("Device selection dialog updated with \(updatedDevices.count) devices.")

        case .deviceSelectionDialogDismissed:
            Self.logger.info("Device selection dialog dismissed.")

        case .tvSelected(let device):
            Self.logger.info("User selected TV: \(device.friendlyName)")

        case .mobileSelected:
            Self.logger.info("User selected to watch on mobile.")

        case .tvConnecting(let device):
            Self.logger.info("Connecting to TV: \(device.friendlyName)")

        case .tvConnected(let device):
            Self.logger.info("Connected to TV: \(device.friendlyName)")

        case .tvConnectionFailed(let device, let error):
            Self.logger.error("Failed to connect to TV: \(device.friendlyName). Error: \(error ?? "Unknown")")

        case .tvDisconnected(let device, let reason):
            Self.logger.info("Disconnected from TV: \(device.friendlyName). Reason: \(reason ?? "Unknown")")

        case .videoStateChanged(let title, _, let state, let position, _, _):
            Self.logger.info("Video \'\(title)\' state changed to \(state) at position \(position)")

        default:
            // This handles any future event types gracefully.
            break
        }
    }
}
```
