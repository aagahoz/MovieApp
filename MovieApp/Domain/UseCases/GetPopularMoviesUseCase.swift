//
//  GetPopularMoviesUseCase.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import Foundation

final class GetPopularMoviesUseCase {
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func execute(page: Int,
                 completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        
        self.repository.fetchPopularMovies(page: page, completion: completion)
        
    }
    
}
