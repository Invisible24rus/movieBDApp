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
    
    private enum CodingKeys: String, CodingKey {
      case posterPath = "poster_path"
    }
    
}

extension Movie {
    var poster: URL? { posterPath?.asTmdbImageUrl() }
}


//extension Movie {
//    static var spiderman: Movie {
//        Movie(posterPath: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
//    }
//}


