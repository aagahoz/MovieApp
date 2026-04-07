//
//  APIClientProtocol.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import Foundation

protocol APIClientProtocol {
    
    func request<T: Decodable>(
            endpoint: Endpoint,
            completion: @escaping (Result<T, NetworkError>) -> Void
        )
    
}
