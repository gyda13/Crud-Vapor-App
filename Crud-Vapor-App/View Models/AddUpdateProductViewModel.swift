//
//  AddUpdateProductViewModel.swift
//  Crud-Vapor-App
//
//  Created by gyda almohaimeed on 07/07/1444 AH.
//

import SwiftUI


final class AddUpdateProductViewModel: ObservableObject {
    
    @Published var productName = ""
    @Published var actualPrice = 0.0
    @Published var workPrice = 0.0
    @Published var profitPrice = 0.0
    @Published var Quintity = 0
    
    
    
    
    var productID: UUID?
    
    var isUpdating: Bool {
        productID != nil
    }
    
    var buttonTitle: String {
        productID != nil ? "Update Product" : "Add Product"
    }
    
    init() {
        
    }
    
    init(currentProduct: Product) {
        self.productID = currentProduct.id
        self.productName = currentProduct.name
        self.profitPrice = currentProduct.profit_price
        self.workPrice = currentProduct.work_price
        self.actualPrice = currentProduct.actual_price
        self.Quintity = currentProduct.quantity
 
        
    }

    func addUpdateeAction(completion: @escaping () -> Void) {
        Task{
            do {
                if isUpdating {
                  try await updateProduct()
                } else {
                    try await addProduct()
                }
            } catch {
                print("Error: \(error)")
            }
            
        }
        // wait for the action completes
        completion()
    }
    
    func addProduct() async throws {
        
        let urlString = Constants.baseURL + Endpoints.products
        
        guard let url = URL(string: urlString) else
        {
            throw HttpError.badURL
        }
        
        let product = Product(id: nil, name: productName, actual_price: actualPrice, profit_price: profitPrice, work_price: workPrice,  quantity: Quintity)
        try await HttpClient.shared.sendData(url: url, object: product,
                                             httpMeyhod: HttpMethodes.POST.rawValue)
        
    }
    
    func updateProduct() async throws {
        let urlString = Constants.baseURL + Endpoints.products
        guard let url = URL(string: urlString) else
        {
            throw HttpError.badURL
        }
        let productToUpdate = Product(id: productID, name: productName, actual_price: actualPrice, profit_price: profitPrice, work_price: workPrice,  quantity: Quintity)
        try await HttpClient.shared.sendData(url: url, object: productToUpdate,
                                             httpMeyhod: HttpMethodes.PUT.rawValue)
        
    }
}
