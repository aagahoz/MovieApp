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
        
        APIClient.shared.fetchMovies { result in
            switch result {
            case .success(let movies):
                for item in movies {
                    print(item)
                    print()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
