//
//  DogAPI.swift
//  Using Dog API
//
//  Created by Pankaj Kulkarni on 30/03/19.
//  Copyright © 2019 iManifest. All rights reserved.
//

import UIKit

class DogAPI {
    enum EndPoint {
        case randomImageFromAllDogs
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogs:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
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
    
    
    fileprivate static func fetchJSONForUrl(_ url: URL, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let imageData = try decoder.decode(DogImage.self, from: data)
                completionHandler(imageData, nil)
            } catch {
                completionHandler(nil, error)
            }
            
        }
        
        task.resume()
    }
    
    class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> Void) {
        
        fetchJSONForUrl(EndPoint.randomImageFromAllDogs.url, completionHandler: completionHandler)
    }
    
    
    class func requestRandomImage(for breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void){
        let breedURL = EndPoint.randomImageForBreed(breed).url
        fetchJSONForUrl(breedURL, completionHandler: completionHandler)
    }
    
    
    class func requestAllBreeds(completionHandler: @escaping ([String], Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: EndPoint.listAllBreeds.url) { (data, response, error) in
            
            guard let data = data else {
                completionHandler([], error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let breedsResponse = try decoder.decode(BreedsListResponse.self, from: data)
                let breeds = breedsResponse.message.keys.map {$0}
                completionHandler(breeds, nil)
                
            } catch {
                completionHandler([], error)
            }
            
        }
        
        task.resume()
        
    }
}
