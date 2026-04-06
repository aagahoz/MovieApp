//
//  ViewController.swift
//  MovieApp
//
//  Created by Agah on 6.04.2026.
//

import UIKit

final class ViewController: UIViewController {
    
    private let getPopularMoviesUseCase = GetPopularMoviesUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovies()
    }
    
    private func fetchMovies() {
        
        getPopularMoviesUseCase.execute { result in
        
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    movies.forEach { print($0.title) }
                case .failure(let error):
                    print("Hata: \(error)")
                }
            }
            
        }
        
    }
    
}
