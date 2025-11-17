//
//  ContentView.swift
//  TMobilePlayApp
//
//  Created on 11/10/2025.
//

import SwiftUI
import VizbeeKit
import VizbeeTPlayKit

struct ContentView: View {
    @StateObject private var viewModel = VideoListViewModel()
    @State private var viewController: UIViewController?
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color.black.ignoresSafeArea()
                
                // Content
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.videos) { video in
                            VideoRowView(video: video) {
                                // Handle watch button tap
                                if let vc = viewController {
                                    viewModel.playVideo(video, in: vc)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Logo in the center
                ToolbarItem(placement: .principal) {
                    Image("t_mobile_play_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 32)
                }
                
                // Cast button on the right
                if #available(iOS 26.0, *) {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        VTPCastButton.SwiftUIView(size: CGSize(width: 24, height: 24))
                            .frame(width: 24, height: 24)
                    }.sharedBackgroundVisibility(Visibility.hidden)
                } else {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        VTPCastButton.SwiftUIView(size: CGSize(width: 24, height: 24))
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .background(ViewControllerExtractor(viewController: $viewController))
        }
        .navigationViewStyle(.stack)
        .preferredColorScheme(.dark)
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            if let error = viewModel.errorMessage {
                Text(error)
            }
        }
    }
}

// Helper to extract UIViewController from SwiftUI
struct ViewControllerExtractor: UIViewControllerRepresentable {
    @Binding var viewController: UIViewController?
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        DispatchQueue.main.async {
            self.viewController = vc
        }
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        DispatchQueue.main.async {
            self.viewController = uiViewController
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
