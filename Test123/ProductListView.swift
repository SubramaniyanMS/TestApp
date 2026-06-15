//
//  ProductListView.swift
//  Test123
//
//  Created by Apple on 07/05/26.
//

import SwiftUI

struct ProductListView: View {
    
    @StateObject private var vm = ProductVM()
    
    var body: some View {
        NavigationView {
            Group {
                if let errorMsg = vm.errorMsg {
                    Text(errorMsg)
                        .foregroundColor(.red)
                } else {
                    List(vm.products) { post in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(post.title ?? "")
                                .font(.headline)
                            Text(post.body ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 4)
                        
                    }
                }
            }
            .navigationTitle("Products")
        }
        .task {
            await vm.fetchProducts()
        }
    }
}
