//
//  GetPopularMoviesUseCase.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import Foundation

final class GetPopularMoviesUseCase {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    func execute(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        
        apiClient.request(endpoint: .popularMovies()) { (result: Result<MovieResponse, NetworkError>) in
            
            switch result {
            case .success(let response):
                let movies = response.results.map { $0.toDomain() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
    
}
