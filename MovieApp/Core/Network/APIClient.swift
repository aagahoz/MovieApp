//
//  APIClient.swift
//  MovieApp
//
//  Created by Agah on 6.04.2026.
//

import Foundation


final class APIClient: APIClientProtocol {
    
    static let shared = APIClient()
    
    private init() {}
    
    func request<T: Decodable> (
        endpoint: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) -> URLSessionDataTask? {
        
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if error != nil {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }
            
        }
        task.resume()
        
        return task
    }
    
}
