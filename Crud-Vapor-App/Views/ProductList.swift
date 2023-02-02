//
//  ProductList.swift
//  Crud-Vapor-App
//
//  Created by gyda almohaimeed on 07/07/1444 AH.
//

import SwiftUI

struct ProductList: View {
    
    @StateObject var viewModel = ProductListViewModel()
    @ObservedObject var updateViewModel = AddUpdateProductViewModel()
    
    @State var modal: ModalType? = nil

    var body: some View {
        
        NavigationView {
            List{
                ForEach(viewModel.products){ product in
            
                    Button {
                        modal = .update(product)
                    } label: {
                       
                        Text(product.name + "\n Cost price: \(product.actual_price)" + "\n Work price:  \(product.work_price)"
                             + "\n Profit price: \(product.profit_price)"
                             
                        )
                            .font(.title3)
                            .foregroundColor(.black)
                      

                    }
                    
                }.onDelete(perform: viewModel.delete)
            }
            .navigationTitle(Text("📦 Products"))
            .toolbar {
                Button{
                    modal = .add
                } label: {
                    Label("Add Product", systemImage: "plus.circle")
                }
            }
                
        }
        .sheet(item: $modal, onDismiss: {
            // on dismiss code so after adding product dismiss sheet
            Task{
                do {
                    try await viewModel.fetchProducts()
                } catch {
                    print("Error: \(error)")
                }
            }
         
        }) { modal in
            switch modal {
            case .add:
                AddProduct(viewModel: AddUpdateProductViewModel())
            case .update(let product):
                UpdateView(viewModel: AddUpdateProductViewModel(currentProduct: product))
            }
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductList()
    }
}
