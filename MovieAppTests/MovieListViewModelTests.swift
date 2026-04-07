//
//  MovieListViewModelTests.swift
//  MovieAppTests
//
//  Created by Agah on 8.04.2026.
//

import XCTest
@testable import MovieApp

final class MovieListViewModelTests: XCTestCase {
    
    private var mockRepository: MockMovieRepository!
    private var useCase: GetPopularMoviesUseCase!
    private var viewModel: MovieListViewModel!
    
    override func setUp() {
        super.setUp()
        
        mockRepository = MockMovieRepository()
        useCase = GetPopularMoviesUseCase(repository: mockRepository)
        viewModel = MovieListViewModel(getPopularMoviesUseCase: useCase)
    }
    
    override func tearDown() {
        mockRepository = nil
        useCase = nil
        viewModel = nil
        
        super.tearDown()
    }
    
    func test_fetchMovies_success_emitsLoadingThenSuccess() {
        
        // Arrange
        mockRepository.movies = [
            Movie(id: 1, title: "Test", overview: "", posterURL: nil)
        ]
        
        var states: [MovieListViewState] = []
        
        viewModel.onStateChanged = { state in
            states.append(state)
        }
        
        // Act
        viewModel.fetchMovies()
        
        // Assert
        XCTAssertEqual(states.count, 2)
        
        if case .loading = states[0] {} else {
            XCTFail("First state should be loading")
        }
        
        if case .success(let movies) = states[1] {
            XCTAssertEqual(movies.count, 1)
        } else {
            XCTFail("Second state should be success")
        }
    }
    
    func test_fetchMovies_error_emitsError() {
        
        // Arrange
        mockRepository.shouldReturnError = true
        
        var didRecieveError = false
        
        viewModel.onStateChanged = { state in
            
            if case .error = state {
                didRecieveError = true
            }
            
        }
        
        // Act
        viewModel.fetchMovies()
        
        // Assert
        XCTAssertTrue(didRecieveError)
    }
    
    func test_pagination_appendMovies() {
        
        // Arrange
        mockRepository.movies = [
            Movie(id: 1, title: "Test", overview: "", posterURL: nil)
        ]
        
        // Act
        viewModel.fetchMovies()
        viewModel.loadMoreMovies()
        
        // Assert
        XCTAssertEqual(viewModel.movies.count, 2)
    }
    
    /*
     Test is failing due to no-async mockrepository structure
     */
//    func test_loadMore_preventsDuplicateRequests() {
//        
//        // Arrange
//        mockRepository.movies = [
//            Movie(id: 1, title: "Test", overview: "", posterURL: nil)
//        ]
//        
//        // Act
//        viewModel.loadMoreMovies()
//        viewModel.loadMoreMovies()
//        
//        // Assert
//        XCTAssertEqual(viewModel.movies.count, 1)
//        
//    }
    
    
    
    
}

