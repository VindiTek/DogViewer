//
//  SubbreedListRouter.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import Foundation

final class SubbreedListRouter {
    
    weak var controller: SubbreedListVC!
    
    func openImagesScreen(ofBreed breed: String, withSubBreed subbreed: String? = nil) {
        let vc = ImagesListVC.instantiate()
        let request: Request
        let title: String
        if let subbreed = subbreed {
            request = Request.allDogImagesInBreedWithSubbreed(breed, subbreed)
            title = subbreed
        } else {
            request = Request.allDogImagesInBreed(breed)
            title = "All"
        }
        let presenter = ImagesListPresenter(request: request, title: title)
        vc.presenter = presenter
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
}

