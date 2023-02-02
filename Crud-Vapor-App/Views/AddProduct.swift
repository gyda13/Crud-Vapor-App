//
//  AddUpdateProduct.swift
//  Crud-Vapor-App
//
//  Created by gyda almohaimeed on 07/07/1444 AH.
//

import SwiftUI

struct AddProduct: View {
    
    @ObservedObject var viewModel = AddUpdateProductViewModel()
    @Environment(\.presentationMode) var presentationMode
  
    @State var profitP = 0.0
    @State var costP = ""
    @State var quint = ""
    @State var workP = ""

    
    var body: some View {
        VStack{
            TextField("Product Name:", text: $viewModel.productName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
          
            TextField("Work Price:", text: $workP)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
            
          
            
            TextField("Cost Price:", text: $costP)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
            
       
            Stepper("Profit Percentage % :  \(profitP, specifier: "%.2f")", value: $profitP, in: 0...100, step: 5)
                .padding()
  
            Button {
                viewModel.actualPrice = Double(costP)!
                viewModel.workPrice = Double(workP)!
                viewModel.profitPrice = (Double(costP)! + Double(workP)!) * (Double(profitP) / 100.0)
           
                viewModel.addUpdateeAction {
                    presentationMode.wrappedValue.dismiss()

                }
            } label : {
                HStack{
                    Text("Add Product ")
                    Image(systemName: "plus.circle")
                }
                    .font(.title3.bold())
                    .padding(12)
                    .background(Color(.tintColor))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }.padding(.top, 80.0)
        }
    }
}
        struct AddProduct_Previews: PreviewProvider {
            static var previews: some View {
                AddProduct(viewModel: AddUpdateProductViewModel())
            }
        }
    
