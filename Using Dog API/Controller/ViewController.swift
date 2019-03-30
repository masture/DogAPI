//
//  ViewController.swift
//  Using Dog API
//
//  Created by Pankaj Kulkarni on 30/03/19.
//  Copyright © 2019 iManifest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomImageEndPoint = DogAPI.EndPoint.randomImageFromAllDogs.url
        
        let task = URLSession.shared.dataTask(with: randomImageEndPoint) { (data, response, error) in
            
            guard let data = data else {
                print("Error: \(String(describing: error))")
                return
            }

            let decoder = JSONDecoder()
            do {
                let imageData = try decoder.decode(DogImage.self, from: data)
                print(imageData)
                let dogImageURL = URL(string: imageData.message)!
                
                DogAPI.requestImageFile(url: dogImageURL, completionHandler: { (image, error) in
                    
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                    
                })
                
                
            } catch {
                print("Error decoding JSON data")
                return
            }
        }
        
        task.resume()
    }


}

