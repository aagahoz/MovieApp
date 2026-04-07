//
//  MovieRepository.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import Foundation

protocol MovieRepository {
    
    func fetchPopularMovies(page: Int,
                            completion: @escaping (Result<[Movie], NetworkError>) -> Void)
    
}
