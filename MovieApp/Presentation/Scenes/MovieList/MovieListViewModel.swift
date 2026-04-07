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
    
//    var onMoviesUpdated: (() -> Void)?
//    var onError: ((String) -> Void)?
    var onStateChanged: ((MovieListViewState) -> Void)?
    
    init(getPopularMoviesUseCase: GetPopularMoviesUseCase = GetPopularMoviesUseCase()) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
    }
    
    func fetchProducts() {
        
        getPopularMoviesUseCase.execute { [weak self] result in
        
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.onStateChanged?(.success(movies))
//                self?.onMoviesUpdated?()
            case .failure(let error):
                self?.onStateChanged?(.error("Something went wrong"))
//                self?.onError?("Something went wrong")
            }
            
        }
        
    }
    
}
