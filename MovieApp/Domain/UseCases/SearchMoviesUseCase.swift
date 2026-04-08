//
//  SearchMoviesUseCase.swift
//  MovieApp
//
//  Created by Agah on 8.04.2026.
//

import Foundation

final class SearchMoviesUseCase {
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func execute(query: String, page: Int, completion: @escaping (Result<[Movie], NetworkError>) -> Void) -> URLSessionDataTask? {
        
        return repository.searchMovies(query: query, page: page, completion: completion)
        
    }
    
}
