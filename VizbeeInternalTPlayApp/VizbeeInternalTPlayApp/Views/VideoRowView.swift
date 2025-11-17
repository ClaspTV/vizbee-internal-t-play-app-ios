//
//  VideoRowView.swift
//  TMobilePlayApp
//
//  Created on 11/10/2025.
//

import SwiftUI

struct VideoRowView: View {
    let video: Video
    let onWatchTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            // Thumbnail
            AsyncImage(url: URL(string: video.thumbnailUrl)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 85, height: 96)
                        .cornerRadius(12)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 85, height: 96)
                        .cornerRadius(12)
                        .clipped()
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 85, height: 96)
                        .cornerRadius(12)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        )
                @unknown default:
                    EmptyView()
                }
            }
            
            // Title and Subtitle - centered vertically
            VStack(alignment: .leading, spacing: 8) {
                Text(video.title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                Text(video.subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Watch Free Button - positioned at bottom right
            VStack {
                Spacer()
                
                Button(action: onWatchTapped) {
                    Text("Watch Free")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            Color(red: 0.91, green: 0.0, blue: 0.54) // T-Mobile magenta
                        )
                        .cornerRadius(8)
                }
            }
            .frame(height: 80) // Match thumbnail height
        }
        .padding(8)
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(16)
    }
}
