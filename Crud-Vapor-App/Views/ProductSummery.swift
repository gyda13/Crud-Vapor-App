//
//  ProductSummery.swift
//  Crud-Vapor-App
//
//  Created by gyda almohaimeed on 11/07/1444 AH.
//

import SwiftUI

struct ProductSummery: View {
        @StateObject var viewModel = ProductListViewModel()

        var body: some View {
            
            NavigationView {
                List{
                    ForEach(viewModel.products){ product in
                
                        Button {
                           
                        } label: {
                           
                            Text(product.name + "\n Quantity = \(product.quantity)"
                                 + "\n Profit price =  \((product.profit_price) * Double(product.quantity))"
                                 
                            )
                                .font(.title3)
                                .foregroundColor(.black)
                          

                        }
                        
                    }.onDelete(perform: viewModel.delete)
                }
                .navigationTitle(Text("📉 Products Summary"))
              
                    
            }
            .onAppear {
                Task {
                    do{
                        try await viewModel.fetchProducts()
                    } catch {
                        print("Error: \(error)")
                    }
                    }
            }
        }    }


struct ProductSummery_Previews: PreviewProvider {
    static var previews: some View {
        ProductSummery()
    }
}
