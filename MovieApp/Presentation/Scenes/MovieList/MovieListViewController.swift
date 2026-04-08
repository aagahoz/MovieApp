//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    private let viewModel: MovieListViewModel
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let footerSpinner = UIActivityIndicatorView(style: .medium)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let errorView = ErrorView()
    
    private var movies: [Movie] = []
    private var searchWorkItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
        viewModel.fetchMovies()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height * 2 {
            viewModel.loadMoreMovies()
        }
        
    }
    
    
    private func bindViewModel() {
            
        
        viewModel.onStateChanged = { [weak self] state in
            
            guard let self = self else { return }
                        
            DispatchQueue.main.async{
                switch state {
                    case .loading:
                        self.activityIndicator.startAnimating()
                        self.footerSpinner.stopAnimating()
                        self.errorView.isHidden = true
                    
                case .paginationLoading:
                        self.activityIndicator.stopAnimating()
                        self.footerSpinner.startAnimating()
                        
                    
                    case .success(let movies):
                        self.activityIndicator.stopAnimating()
                        self.footerSpinner.stopAnimating()
                        self.errorView.isHidden = true
                    
                        self.movies = movies
                        self.tableView.reloadData()
                    
                    case .error(let error):
                        self.activityIndicator.stopAnimating()
                        self.footerSpinner.stopAnimating()
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
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.dataSource = self
        tableView.delegate = self
                
        view.addSubview(tableView)
        
        footerSpinner.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        footerSpinner.hidesWhenStopped = true
        
        tableView.tableFooterView = footerSpinner
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.isHidden = true
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

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            self?.viewModel.search(query: searchText)
        }
        
        searchWorkItem = workItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
        
    }
    
}
