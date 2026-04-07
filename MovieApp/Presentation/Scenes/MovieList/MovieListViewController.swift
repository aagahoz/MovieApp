//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    private let viewModel = MovieListViewModel()
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let errorView = ErrorView()
    
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
        viewModel.fetchMovies()
    }
    
    private func bindViewModel() {
        
        viewModel.onStateChanged = { [weak self] state in
            
            guard let self = self else { return }
                        
            DispatchQueue.main.async{
                switch state {
                    case .loading:
                        self.errorView.isHidden = true
                        print("Show Loading")
                        self.activityIndicator.startAnimating()
                    
                    case .success(let movies):
                        self.activityIndicator.stopAnimating()
                        print(movies)
                        self.movies = movies
                        self.tableView.reloadData()
                    
                    case .error(let error):
                        self.activityIndicator.stopAnimating()
                        self.errorView.isHidden = false
                        print(error)
                }
            }
        }
        
        errorView.onRetry = { [weak self] in
            self?.viewModel.fetchMovies()
        }
        
    }
    
    
    private func setupUI() {
        
        view.backgroundColor = .systemBackground
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.dataSource = self
        tableView.delegate = self
                
        view.addSubview(tableView)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }    
}
