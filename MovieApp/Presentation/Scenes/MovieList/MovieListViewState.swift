//
//  MovieListViewState.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import Foundation


enum MovieListViewState {
    case loading
    case paginationLoading
    case success([Movie])
    case error(String)
}
