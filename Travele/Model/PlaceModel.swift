//
//  DestinationModel.swift
//  Travele
//
//  Created by fahmi dwi on 02/06/21.
//  Copyright © 2021 Dicoding Indonesia. All rights reserved.
//

import Foundation

class PlaceModel: Codable {
    let id: Int
    let name: String
    let description: String
    let address: String
    let longitude: Double
    let latitude: Double
    let like: Int
    let image: String
}
