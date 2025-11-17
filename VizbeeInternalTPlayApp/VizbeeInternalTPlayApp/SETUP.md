# Setup Guide for Xcode

## Creating the Xcode Project

Since the files have been created outside of Xcode, follow these steps to set up your Xcode project:

### Option 1: Create New Project and Add Files

1. **Create New Xcode Project**
   - Open Xcode
   - Select **File → New → Project**
   - Choose **iOS → App**
   - Product Name: `TMobilePlayApp`
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Save the project

2. **Add Source Files**
   - Delete the default `ContentView.swift` and `TMobilePlayAppApp.swift` files
   - Drag all the Swift files from the project folders into Xcode:
     - `TMobilePlayApp.swift`
     - `AppDelegate.swift`
     - `Models/Video.swift`
     - `Data/VideoRepository.swift`
     - `ViewModels/VideoListViewModel.swift`
     - `Views/ContentView.swift`
     - `Views/VideoRowView.swift`
   - Make sure **"Copy items if needed"** is checked
   - Select **"Create groups"** for folder references

3. **Add Assets**
   - Delete the default `Assets.xcassets` folder in Xcode
   - Drag the `Assets.xcassets` folder from the project into Xcode
   - Make sure **"Copy items if needed"** is checked

4. **Replace Info.plist**
   - Replace your project's `Info.plist` with the provided one
   - Or manually add the required keys for local network and Bonjour services

### Option 2: Use Existing Files Structure

If you prefer to work with the file structure as-is:

1. Create a workspace or project pointing to the `/home/claude/TMobilePlayApp` directory
2. Configure build settings to recognize the source files
3. Add the framework as described below

## Adding VizbeeTPlay Framework

### Manual Framework Integration

1. **Add Framework**
   - Obtain the `VizbeeKit.xcframework` from Vizbee
   - In Xcode, select your project in the navigator
   - Select your target
   - Go to **General** tab
   - Under **Frameworks, Libraries, and Embedded Content**, click **+**
   - Click **Add Other... → Add Files...**
   - Navigate to and select `VizbeeKit.xcframework`
   - Ensure **Embed & Sign** is selected

2. **Configure Framework Search Paths**
   - Go to **Build Settings**
   - Search for **Framework Search Paths**
   - Add the path where `VizbeeKit.xcframework` is located

### CocoaPods (Alternative)

If Vizbee provides a CocoaPods spec, create a `Podfile`:

```ruby
platform :ios, '15.0'
use_frameworks!

target 'TMobilePlayApp' do
  # Add Vizbee pod when available
  # pod 'VizbeeKit', '~> x.x.x'
end
```

Then run:
```bash
pod install
```

## Configuration

### Update App ID

1. Open `AppDelegate.swift`
2. Replace `"YOUR_VIZBEE_APP_ID"` with your actual Vizbee App ID
3. Update the `supportedApps` dictionary with your TV app IDs

### Verify Info.plist

Ensure these keys are present:
- `NSLocalNetworkUsageDescription`
- `NSBonjourServices` with `_vizbee._tcp`

## Build Settings

### Minimum iOS Version
- Set **iOS Deployment Target** to **iOS 15.0** or higher

### Swift Version
- Ensure **Swift Language Version** is set to **Swift 5** or higher

### Code Signing
- Configure your **Team** and **Bundle Identifier**
- Enable automatic signing or configure manual signing

## Running the App

1. Select a simulator or connected device
2. Click **Run** (⌘R)
3. The app should launch showing the video list
4. Tap the cast button to see available devices
5. Tap "Watch Free" on any video to start playback

## Troubleshooting

### Build Errors

**"No such module 'VizbeeKit'"**
- Verify the framework is properly added and embedded
- Check Framework Search Paths
- Clean build folder (⇧⌘K) and rebuild

**"Symbol not found"**
- Ensure the framework is set to **Embed & Sign**, not **Do Not Embed**
- Verify the framework architecture matches your target

### Runtime Issues

**Cast button doesn't appear**
- Check that SDK initialization in `AppDelegate` completes
- Look for initialization errors in console
- Verify network permissions are granted

**Video playback fails**
- Confirm your Vizbee App ID is correct
- Check that deep link URLs are valid for your content providers
- Enable debug mode to see detailed logs

## File Structure Reference

```
TMobilePlayApp/
├── TMobilePlayApp.swift
├── AppDelegate.swift
├── Info.plist
├── Models/
│   └── Video.swift
├── Data/
│   └── VideoRepository.swift
├── ViewModels/
│   └── VideoListViewModel.swift
├── Views/
│   ├── ContentView.swift
│   └── VideoRowView.swift
└── Assets.xcassets/
    ├── Contents.json
    └── t_mobile_play_logo.imageset/
        ├── Contents.json
        └── t_mobile_play_logo.png
```

## Next Steps

1. Obtain your Vizbee App ID from the Vizbee dashboard
2. Configure the supported apps mapping
3. Test on a physical device (casting may not work in simulator)
4. Customize the UI as needed
5. Add any additional features required

## Support Resources

- **Vizbee Documentation**: Check the official Vizbee SDK documentation
- **API Reference**: Refer to VizbeeTPlay SDK API documentation
- **Sample Code**: Review the provided source code and comments
