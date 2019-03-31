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
    @IBOutlet weak var breedPickerView: UIPickerView!
    
    var breeds = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        breedPickerView.dataSource = self
        breedPickerView.delegate = self
        
        fetchBreedList()

    }
    
    
    private func fetchBreedList() {
        
        DogAPI.requestAllBreeds(completionHandler: handleBreedsListResponse(breeds:error:))
        
    }
    
    private func hanldeRandomImageResponse(dogImage: DogImage?, error: Error?) {
        guard let dogImage = dogImage else {
            print("Error fetching random dog: \(String(describing: error))")
            return
        }
        
        let dogImageURL = URL(string: dogImage.message)!
        
        DogAPI.requestImageFile(url: dogImageURL, completionHandler: handleImageFileResponse(image:errro:))
    }

    
    private func handleImageFileResponse(image: UIImage?, errro: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    private func handleBreedsListResponse(breeds: [String], error: Error?) {
        self.breeds = breeds
        DispatchQueue.main.async {
            self.breedPickerView.reloadAllComponents()
        }
    }

}


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(for: breeds[row], completionHandler: hanldeRandomImageResponse(dogImage:error:))
    }
    
    
}
