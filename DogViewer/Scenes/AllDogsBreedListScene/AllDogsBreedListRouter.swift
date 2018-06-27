//
//  AllDogsBreedListRouter.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import Foundation

final class AllDogsBreedListRouter {
    
    weak var controller: AllDogsBreedListVC!
    
    func openSubbreedsScreen(ofBreed breed: String, andSubbreeds subbreeds: [String]) {
        let vc = SubbreedListVC.instantiate()
        let presenter = SubbreedListPresenter(breed: breed, subbreeds: subbreeds)
        vc.presenter = presenter
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openImagesScreen(ofBreed breed: String) {
        let vc = ImagesListVC.instantiate()
        let request = Request.allDogImagesInBreed(breed)
        let presenter = ImagesListPresenter(request: request, title: breed)
        vc.presenter = presenter
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
}

