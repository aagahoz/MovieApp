//
//  NetworkError.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import Foundation

enum NetworkError: Error {
    
    case invalidURL
    case noData
    case decodingError
    case serverError
    
}
