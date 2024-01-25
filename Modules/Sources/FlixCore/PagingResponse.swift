//
//  File.swift
//  
//
//  Created by alex on 1/23/24.
//

import Foundation

struct PagingResponse<T: Codable>: Codable {
    let page: Int
    let results: T
    let totalPages: Int
    let totalResults: Int
}
