//
//  UBikeResponseModel.swift
//  OCP
//
//  Created by WY NG on 10/11/2019.
//  Copyright © 2019 natalie. All rights reserved.
//

import Foundation

struct UBikeResponseModel: Codable {
    let retCode: Int
    let retVal: [String: UBikeStation]
}

struct UBikeStation: Codable {
    let sno, sna, tot, sbi, sarea: String
    let mday, lat, lng, ar, sareaen: String
    let snaen, aren, bemp, act: String
}
