//
//  ProductListViewModel.swift
//  Crud-Vapor-App
//
//  Created by gyda almohaimeed on 07/07/1444 AH.
//

import SwiftUI


class ProductListViewModel: ObservableObject {
    @Published var products = [Product]()
    
    func fetchProducts() async throws {
        let urlString = Constants.baseURL + Endpoints.products
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let productResponse: [Product] = try await HttpClient.shared.fetch(url: url)
        DispatchQueue.main.async {
            self.products = productResponse
        }
        
    }
    
    
    
    
    func delete(at offesets: IndexSet) {
        
        // delete the product from the database
        offesets.forEach { i in
            guard let productId = products[i].id else {
                return
            }
            guard let url = URL(string: Constants.baseURL + Endpoints.products
             + "/\(productId)") else {
                return
            }
            
            Task {
                do {
                    try await HttpClient.shared.delete(at: productId, url: url)
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        
        // delet the product from the Producr array in the view
        products.remove(atOffsets: offesets)
   }
            
}

