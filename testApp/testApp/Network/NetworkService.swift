//
//  NetworkService.swift
//  testApp
//
//  Created by NIKITA NIKOLICH on 09.05.2022.
//

import Foundation

typealias JSONDict = [String: Any]

class NetworkService {
    let baseURL = "https://api.themoviedb.org/3/"
    let apiKey = "3ffeca8b167f6d54cb8099af3bda45ea"
    let endpoint = "movie/popular"
    
    func fetchMovie(page: Int, completion: @escaping (Result<MovieResponce, NetworkError>) -> Void) {
        getData(endpoint: endpoint,
                parameters: ["api_key": apiKey,
                             "language": "en-US",
                             "page": page],
                comletion: completion)
    }
    
}


private extension NetworkService {
    
    func getData<T: Decodable>(endpoint: String,
                               parameters: JSONDict,
                               comletion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL.url(with: baseURL, endpoint: endpoint, queryParams: parameters) else {
            comletion(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let responce = responce as? HTTPURLResponse,
                  (200...999).contains(responce.statusCode) else {
                comletion(.failure(.notFound))
                return
            }
            
            guard let data = data,
                  let jsonString = String(data: data, encoding: .utf8),
                  let model = try? JSONDecoder().decode(T.self, from: data) else {
                comletion(.failure(.badJSON))
                return
            }
            
            print(jsonString)
            print(url)
            comletion(.success(model))
        }
        task.resume()
    }
}
