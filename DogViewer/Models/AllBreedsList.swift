//
//  AllBreedsList.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import Foundation

struct ListAllDogBreeds {
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
    }
    
    let status: String
    private let message: [String: [String]]
    
    var breeds: [DogBreed] {
        var output: [DogBreed] = []
        for (breed, subBreeds) in message {
            output.append(DogBreed(name: breed, subBreed: subBreeds))
        }
        return output
    }
    
}

extension ListAllDogBreeds: Codable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encode(message, forKey: .message)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(String.self, forKey: .status)
        message = try values.decode([String: [String]].self, forKey: .message)
    }
}
