//
//  ResponseModel.swift
//  Travele
//
//  Created by fahmi dwi on 02/06/21.
//  Copyright © 2021 Dicoding Indonesia. All rights reserved.
//

import Foundation

class ResponseModel: Codable {
    let error: Bool
    let message: String
    let count: Int
    let places: [PlaceModel]
}
