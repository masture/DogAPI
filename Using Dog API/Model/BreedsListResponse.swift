//
//  BreedsListResponse.swift
//  Using Dog API
//
//  Created by Pankaj Kulkarni on 30/03/19.
//  Copyright © 2019 iManifest. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
