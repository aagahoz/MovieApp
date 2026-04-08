//
//  ImagePrefetcher.swift
//  MovieApp
//
//  Created by Agah on 8.04.2026.
//

import UIKit

final class ImagePrefetcher {
    
    static let shared = ImagePrefetcher()
    
    private var runningTasks: [String: URLSessionDataTask] = [:]
    
    private init () {}
    
    func prefetch(urlString: String) {
        
        if ImageCache.shared.get(forkey: urlString) != nil {
            return
        }
        
        if runningTasks[urlString] != nil {
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            
            defer {
                self.runningTasks[urlString] = nil
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            
            ImageCache.shared.set(image, forkey: urlString)
        }
        runningTasks[urlString] = task
        task.resume()       
    }
    
}
