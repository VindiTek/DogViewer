//
//  NetworkingWorker.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import Foundation
import Alamofire

enum Request {
    case allDogsBreedsList
    case allSubbreedsInBreed(String)
    case allDogImagesInBreed(String)
    case allDogImagesInBreedWithSubbreed(String,String)
    
    var url: URL? {
        switch self {
        case .allDogsBreedsList:
            return URL(string: "https://dog.ceo/api/breeds/list/all")
        case .allSubbreedsInBreed(let breed):
            return URL(string: "https://dog.ceo/api/breed/\(breed)/list")
        case .allDogImagesInBreed(let breed):
            return URL(string: "https://dog.ceo/api/breed/\(breed)/images")
        case .allDogImagesInBreedWithSubbreed(let breed, let subbreed):
            return URL(string: "https://dog.ceo/api/breed/\(breed)/\(subbreed)/images")
        }
    }
}

typealias RequestSuccess = (_ result: Any?)->()
typealias RequestFailure = (_ errorText: String)->()

class NetworkingWorker {
    
    static let shared = NetworkingWorker()
    
    private init(){}
    
    func execute<T: Codable>(modelType: T.Type, request: Request, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {
        guard let url = request.url else {
            failure("Failed to init URL for \(request)")
            return
        }
        Alamofire.request(url).responseData { (response) in
            if let error = response.error {
                failure(error.localizedDescription)
                return
            }
            guard let data = response.data else {
                failure("Empty data")
                return
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                success(model)
            } catch {
                failure(error.localizedDescription)
            }
        }
    }
    
}
