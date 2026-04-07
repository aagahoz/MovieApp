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
    
    private var currentPage = 1
    private var isLoading = false
    private var hasMoreData = true
    
    var onStateChanged: ((MovieListViewState) -> Void)?
    
    init(getPopularMoviesUseCase: GetPopularMoviesUseCase = GetPopularMoviesUseCase()) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
    }
    
    func fetchMovies() {
        currentPage = 1
        movies = []
        hasMoreData = true
        
        onStateChanged?(.loading)
        loadMoreMovies()
    }
    
    func loadMoreMovies() {
        
        guard !isLoading, hasMoreData else { return }
        
        isLoading = true
        
        getPopularMoviesUseCase.execute(page: currentPage) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let newMovies):
                if newMovies.isEmpty {
                    hasMoreData = false
                } else {
                    self.currentPage += 1
                    self.movies.append(contentsOf: newMovies)
                    self.onStateChanged?(.success(movies))
                }
                    
            case .failure(let error):
                self.onStateChanged?(.error("Something went wrong"))
            }
            
            self.isLoading = false
        }
    }
}
