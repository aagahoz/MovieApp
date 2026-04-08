//
//  ImageCache.swift
//  MovieApp
//
//  Created by Agah on 8.04.2026.
//

import UIKit

final class ImageCache {
    
    static let shared = ImageCache()
    
    private init() {}
    
    private let cache = NSCache<NSString, UIImage>()
    
    func get(forkey key: String) -> UIImage? {

        return cache.object(forKey: key as NSString)
    }
    
    func set(_ image: UIImage, forkey key: String) {
        
        cache.setObject(image, forKey: key as NSString)
    }
}

