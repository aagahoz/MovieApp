//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    private let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.fetchProducts()
    }
    
    private func bindViewModel() {
        
        viewModel.onMoviesUpdated = {
            DispatchQueue.main.async { [weak self] in
                print("Reload UI")
            }
        }
        
        viewModel.onError = { error in
            print(error)
        }
        
    }
    
}
