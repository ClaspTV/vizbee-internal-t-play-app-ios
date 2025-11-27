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
        Self.logger.info("Analytics Event: \(event.description)")

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
