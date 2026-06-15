//
//  ProductModels.swift
//  Test123
//
//  Created by Apple on 07/05/26.
//

import Foundation

// MARK: - Product
struct Product: Codable, Identifiable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias Products = [Product]
