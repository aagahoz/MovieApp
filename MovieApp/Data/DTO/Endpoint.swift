//
//  Endpoint.swift
//  MovieApp
//
//  Created by Agah on 6.04.2026.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension Endpoint {
    
    static func popularMovies() -> Endpoint {
        return Endpoint(
            
            path: "/3/movie/popular",
            queryItems: [
                URLQueryItem(name: "api_key", value: "3cc929e57d22016ba1d8cae8c4772481")
            ]
            
        )
    }
    
}
