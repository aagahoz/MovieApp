//
//  MovieRepositoryImpl.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import Foundation

final class MovieRepositoryImpl: MovieRepository {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    
    func fetchPopularMovies(page: Int,
                            completion: @escaping (Result<[Movie], NetworkError>) -> Void) -> URLSessionDataTask? {
        
        apiClient.request(endpoint: .popularMovies(page: page)) { (result: Result<MovieResponse, NetworkError>) in
            
            switch result {
            case .success(let response):
                let movies = response.results.map { $0.toDomain() }
                completion(.success(movies))
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
    
    func searchMovies(query: String, page: Int, completion: @escaping (Result<[Movie], NetworkError>) -> Void) -> URLSessionDataTask? {
        
        return apiClient.request(endpoint: .searchMovies(query: query, page: page)) { ( result: Result<MovieResponse, NetworkError>) in
            
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
