//
//  AllDogsBreedListPresenter.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import Foundation

final class AllDogsBreedListPresenter {
    
    private let networking = NetworkingWorker.shared

    let dataSource = AllDogsBreedListDataSource()
    
    func fetchData(success: @escaping ()->(), failure: @escaping RequestFailure) {
        networking.execute(modelType: ListAllDogBreeds.self, request: .allDogsBreedsList, success: { [weak self] (result) in
            guard let resultModel = result as? ListAllDogBreeds else {
                failure("Worng model")
                return
            }
            guard let strongSelf = self else {return}
            strongSelf.dataSource.updateCellsData(cellsData: resultModel.breeds)
            success()
        }, failure: failure)
    }
    
}
