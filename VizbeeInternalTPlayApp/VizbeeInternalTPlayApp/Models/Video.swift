//
//  Video.swift
//  TMobilePlayApp
//
//  Created on 11/10/2025.
//

import Foundation

enum ContentType: String, Codable {
    case movie = "MOVIE"
    case tvShow = "TV_SHOW"
}

struct Video: Identifiable, Codable {
    let id: String
    let title: String
    let subtitle: String
    let thumbnailUrl: String
    let contentType: ContentType
    
    var displayContentType: String {
        switch contentType {
        case .movie:
            return "Movie"
        case .tvShow:
            return "Show"
        }
    }
}
