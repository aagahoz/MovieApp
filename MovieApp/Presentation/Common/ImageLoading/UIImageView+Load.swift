//
//  UIImageView+Load.swift
//  MovieApp
//
//  Created by Agah on 8.04.2026.
//

import UIKit

private var imageTaskKey: UInt8 = 0

extension UIImageView {
    
    
    private var imageTask: URLSessionDataTask? {
        
        get {
            objc_getAssociatedObject(self, &imageTaskKey) as? URLSessionDataTask
        }
        
        set {
            objc_setAssociatedObject(self, &imageTaskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setImage(with urlString: String?) {
        
        imageTask?.cancel()
        image = nil
        
        guard let urlString = urlString,
              let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlString)") else {
            return
        }
        
        if let cached = ImageCache.shared.get(forkey: url.absoluteString) {
            self.image = cached
            return
        } 
                
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                        
            guard let data = data,
                  let image = UIImage(data: data) else { return }
                
            ImageCache.shared.set(image, forkey: url.absoluteString)
            
            DispatchQueue.main.async {
                
                self?.image = image
                
            }
            
        }
        
        imageTask = task
        task.resume()
        
    }
    
    func cancelImageLoad() {
        imageTask?.cancel()
        imageTask = nil
    }
    
    
}

