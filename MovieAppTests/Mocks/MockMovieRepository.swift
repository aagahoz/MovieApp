//
//  MockMovieRepository.swift
//  MovieAppTests
//
//  Created by Agah on 8.04.2026.
//

import Foundation
@testable import MovieApp

final class MockMovieRepository: MovieRepository {
    
    var shouldReturnError = false
    var movies: [Movie] = []
    
    func fetchPopularMovies(page: Int, completion: @escaping (Result<[MovieApp.Movie], MovieApp.NetworkError>) -> Void) {
        
        
        if shouldReturnError {
            completion(.failure(.serverError))
        } else {
            completion(.success(movies))
        }
        
        
    }
    
    
}
