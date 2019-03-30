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
        
        DogAPI.requestRandomImage(completionHandler: self.hanldeRandomImageRequest(dogImage:error:))
    
    }
    
    
    private func hanldeRandomImageRequest(dogImage: DogImage?, error: Error?) {
        guard let dogImage = dogImage else {
            print("Error fetching random dog: \(String(describing: error))")
            return
        }
        
        let dogImageURL = URL(string: dogImage.message)!
        
        DogAPI.requestImageFile(url: dogImageURL, completionHandler: self.handleImageFileResponse(image:errro:))
    }

    
    private func handleImageFileResponse(image: UIImage?, errro: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

}

