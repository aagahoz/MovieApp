//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import Foundation

private enum Mode {
    
    case popular
    case search(query: String)
    
}

final class MovieListViewModel {
    
    private let getPopularMoviesUseCase: GetPopularMoviesUseCase
    private let searchMoviesUseCase: SearchMoviesUseCase
    
    var movies: [Movie] = []
    private var mode: Mode = .popular
    
    private var currentPage = 1
    private var isLoading = false
    private var hasMoreData = true
    
    private var currentQuery: String?
    
    var onStateChanged: ((MovieListViewState) -> Void)?
    
    init(getPopularMoviesUseCase: GetPopularMoviesUseCase,
         searchMoviesUseCase: SearchMoviesUseCase) {
        
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
        self.searchMoviesUseCase = searchMoviesUseCase
    }
    
    func fetchMovies() {
        currentPage = 1
        movies = []
        hasMoreData = true
        
        loadMoreMovies()
    }
    
    func loadMoreMovies() {
        
        guard !isLoading, hasMoreData else { return }
        
        if currentPage == 1 {
            onStateChanged?(.loading)
        } else {
            onStateChanged?(.paginationLoading)
        }
        
        isLoading = true

        switch mode {
            case .popular:
                getPopularMoviesUseCase.execute(page: currentPage) { [weak self] result in
                    
                    self?.handleResult(result)
                }
                
            case .search(let query):
                
                let requestQuery = query
            
                searchMoviesUseCase.execute(query: requestQuery, page: currentPage) { [weak self] result in
                    
                    guard let self = self else { return }
                    
                    if self.currentQuery != requestQuery {
                        return
                    }
                    
                    self.handleResult(result)
                }
            }
    }
    
    private func handleResult(_ result: Result<[Movie], NetworkError>) {
        
        switch result {
        case .success(let newMovies):
            if newMovies.isEmpty {
                hasMoreData = false
            } else {
                currentPage += 1
                self.movies.append(contentsOf: newMovies)
                onStateChanged?(.success(self.movies))
            }
            
        case .failure:
            onStateChanged?(.error("Something went wrong"))
        }
        
        isLoading = false
    }
    
    func search(query: String) {
        
        if query.isEmpty {
            mode = .popular
            currentQuery = nil
            fetchMovies()
            return
        }
        
        mode = .search(query: query)
        currentQuery = query
        
        currentPage = 1
        movies = []
        hasMoreData = true
        
        loadMoreMovies()
    }
}
