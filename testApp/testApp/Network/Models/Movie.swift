//
//  Movie.swift
//  testApp
//
//  Created by NIKITA NIKOLICH on 09.05.2022.
//

import Foundation

struct MovieResponce: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let posterPath: String?
    let overview: String
    let movieName: String
    let releaseDate: String
    let voteAverage: Double
    
    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview
        case movieName = "original_title"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
}

extension Movie {
    var poster: URL? { posterPath?.asTmdbImageUrl() }
}
