//
//  ApiService.swift
//  Travele
//
//  Created by fahmi dwi on 05/06/21.
//  Copyright © 2021 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol ApiServiceDelegate: class {
    func onError()
}

public struct ApiService<Model: Codable> {
    public typealias SuccessCompletionHandler = (_ response: Model?) -> Void
    
    static func get(_ delegate: ApiServiceDelegate?, path: String, url: String, success successCallback: @escaping SuccessCompletionHandler) {
        guard let urlComponent = URLComponents(string: url), let usableUrl = urlComponent.url else {
            delegate?.onError()
            return
        }
        
        var request = URLRequest(url: usableUrl)
        request.httpMethod = "GET"
        
        var dataTask: URLSessionDataTask?
        let defautlSession = URLSession(configuration: .default)
        
        dataTask = defautlSession.dataTask(with: request) { data, response, error in
            defer {
                dataTask = nil
            }
            
            if error != nil {
                delegate?.onError()
                return
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                guard let model = self.parsedModel(with: data, at: path) else {
                    delegate?.onError()
                    return
                }
                successCallback(model)
            }
        }
        dataTask?.resume()
    }
    
    static func parsedModel(with data: Data, at path: String) -> Model? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            if let dictAtPath = json?.value(forKeyPath: path) {
                let jsonData = try JSONSerialization.data(withJSONObject: dictAtPath, options: .prettyPrinted)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let model =  try decoder.decode(Model.self, from: jsonData)
                return model
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
