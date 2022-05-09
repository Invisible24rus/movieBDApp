//
//  String+Extension.swift
//  testApp
//
//  Created by NIKITA NIKOLICH on 09.05.2022.
//

import Foundation

extension String {
    func asTmdbImageUrl() -> URL? {
        URL(string: "https://image.tmdb.org/t/p/w500/\(self)")
    }
}
