//
//  ViewController.swift
//  MovieApp
//
//  Created by Agah on 6.04.2026.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.shared.request(
            endpoint: .popularMovies()
        ) { (result: Result<MovieResponse, NetworkError>) in
                
            switch result {
            case .success(let response):
                print(response.results)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}
