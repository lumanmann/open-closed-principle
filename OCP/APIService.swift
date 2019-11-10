//
//  APIService.swift
//  OCP
//
//  Created by WY NG on 10/11/2019.
//  Copyright © 2019 natalie. All rights reserved.
//

import Foundation

struct APIService {
    
    static func getStationsList(_ completion:@escaping (Error?, UBikeResponseModel?) -> ()) {
        URLSession.shared.dataTask(
            with: URL(string: "https://tcgbusfs.blob.core.windows.net/blobyoubike/YouBikeTP.json")!
        ) { (data, response, error) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let data = data, let result = try? JSONDecoder().decode(UBikeResponseModel.self, from: data) else {
                completion(nil, nil)
                return
            }
            
            completion(nil, result)
            
            }.resume()
    }
}


