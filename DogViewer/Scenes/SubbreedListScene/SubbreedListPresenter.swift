//
//  SubbreedListPresenter.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import Foundation

final class SubbreedListPresenter {

    private let networking = NetworkingWorker.shared
    
    let dataSource = SubbreedListDataSource()
    let breed: String
    
    init(breed: String, subbreeds: [String]) {
        self.breed = breed
        dataSource.updateCellsData(cellsData: subbreeds)
    }
    
    func fetchAllSubbreeds(success: @escaping ()->(), failure: @escaping RequestFailure) {
        networking.execute(modelType: AllSubbreedList.self, request: .allSubbreedsInBreed(breed), success: { [weak self] (result) in
            guard let subbreeds = result as? AllSubbreedList else {
                failure("Result model missmatch")
                return
            }
            guard let strongSelf = self else {return}
            strongSelf.dataSource.updateCellsData(cellsData: subbreeds.message)
            success()
        }, failure: failure)
    }
}
