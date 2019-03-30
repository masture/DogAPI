//
//  DogAPI.swift
//  Using Dog API
//
//  Created by Pankaj Kulkarni on 30/03/19.
//  Copyright © 2019 iManifest. All rights reserved.
//

import UIKit

class DogAPI {
    enum EndPoint: String {
        case randomImageFromAllDogs = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
        
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
            
        }
        
        task.resume()
    }
}
