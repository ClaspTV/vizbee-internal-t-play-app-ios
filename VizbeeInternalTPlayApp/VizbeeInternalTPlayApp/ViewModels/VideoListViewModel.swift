//
//  VideoListViewModel.swift
//  TMobilePlayApp
//
//  Created on 11/10/2025.
//

import Foundation
import SwiftUI
import Combine  // ← ADDED: Required for @Published
import VizbeeKit
import VizbeeTPlayKit

@MainActor
class VideoListViewModel: ObservableObject {
    @Published var videos: [Video] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository = VideoRepository.shared
    
    init() {
        loadVideos()
    }
    
    func loadVideos() {
        videos = repository.getSampleVideos()
    }
    
    func playVideo(_ video: Video, in viewController: UIViewController) {
        isLoading = true
        errorMessage = nil
        
        Task {
            // Create VTPVideoInfo from Video model
            // FIXED: Parameter order - mobileDeepLinkUrl comes BEFORE tvDeepLinkUrl
            let videoInfo = VTPVideoInfo(
                mobileDeepLinkUrl: video.id,  // ← FIXED: This parameter comes first
                tvDeepLinkUrl: video.id,      // ← FIXED: This parameter comes second
                title: video.title,
                subtitle: video.subtitle,
                imageUrl: video.thumbnailUrl,
                isLive: false
            )
            
            // Call VizbeeTPlay SDK to start video
            let result = await VizbeeTPlay.shared.startVideo(
                in: viewController,
                videoInfo: videoInfo
            )
            
            // Handle result
            switch result {
            case .success:
                print("✅ Video playback started successfully")
                
            case .failure(let error):
                print("❌ Video playback failed: \(error)")
                self.errorMessage = "Failed to start video: \(error.localizedDescription)"
            @unknown default:
                print("")
            }
            
            isLoading = false
        }
    }
}
