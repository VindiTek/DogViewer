//
//  ImagesListPresenter.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import Foundation

final class ImagesListPresenter {
    
    //MARK: - Open properties
    let dataSource = ImagesListDataSource()
    
    //MARK: - Private properties
    private let request: Request
    private let networking = NetworkingWorker.shared
    let title: String
    
    //MARK: Initializer
    init(request: Request, title: String) {
        self.request = request
        self.title = title
    }

    func fetchData(success: @escaping ()->(), failure: @escaping RequestFailure) {
        networking.execute(modelType: AllImagesOfBreedList.self, request: request, success: { [weak self] (result) in
            guard let imagesResponse = result as? AllImagesOfBreedList else {
                failure("Casting failed to AllImagesOfBreedList")
                return
            }
            guard let strongSelf = self else {return}
            strongSelf.dataSource.updateCellsData(cellsData: imagesResponse.message)
            success()
        }, failure: failure)
    }
    
}
