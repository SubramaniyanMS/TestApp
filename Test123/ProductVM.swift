//
//  ProductVM.swift
//  Test123
//
//  Created by Apple on 07/05/26.
//

import Foundation
internal import Combine

class ProductVM: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var errorMsg: String?
    
    func fetchProducts() async {
        errorMsg = nil
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            errorMsg = "Invalid"
            
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoded = try JSONDecoder().decode([Product].self, from: data)
            
            products = decoded
        } catch {
            errorMsg = error.localizedDescription
        }
    }
}


