//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import Foundation

final class MovieListViewModel {
    
    private let getPopularMoviesUseCase: GetPopularMoviesUseCase
    
    var movies: [Movie] = []
    
    var onStateChanged: ((MovieListViewState) -> Void)?
    
    init(getPopularMoviesUseCase: GetPopularMoviesUseCase = GetPopularMoviesUseCase()) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
    }
    
    func fetchMovies() {
        
        getPopularMoviesUseCase.execute { [weak self] result in
        
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.onStateChanged?(.success(movies))
            case .failure(let error):
                self?.onStateChanged?(.error("Something went wrong"))
            }
            
        }
        
    }
    
}
