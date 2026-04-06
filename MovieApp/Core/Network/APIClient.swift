//
//  APIClient.swift
//  MovieApp
//
//  Created by Agah on 6.04.2026.
//

import Foundation


final class APIClient {
    
    static let shared = APIClient()
    
    private init() {}
    
    func fetchMovies(completion: @escaping (Result<[MovieDTO], Error>) -> Void) {
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=3cc929e57d22016ba1d8cae8c4772481"

        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
        
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                print(data)
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(error))
            }
            
            
            
        }.resume()
    }
    
}
