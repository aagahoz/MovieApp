//
//  MovieDTO.swift
//  MovieApp
//
//  Created by Agah on 6.04.2026.
//

import Foundation

struct MovieResponse: Codable {
    let results: [MovieDTO]
}


struct MovieDTO: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }
}

extension MovieDTO {
    
    func toDomain() -> Movie {
        return Movie(
            id: id,
            title: title,
            overview: overview,
            posterURL: posterPath
        )
    }
    
}
