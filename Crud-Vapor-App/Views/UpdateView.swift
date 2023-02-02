//
//  UpdateView.swift
//  Crud-Vapor-App
//
//  Created by gyda almohaimeed on 09/07/1444 AH.
//

import SwiftUI

struct UpdateView: View {
    
    @ObservedObject var viewModel = AddUpdateProductViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var q = ""
    
    var body: some View {
        VStack{
            TextField("product name:", text: $viewModel.productName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
          
           
            
            TextField("Quintitiy:", text: $q)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button {
                viewModel.Quintity += Int(q)! 
                viewModel.addUpdateeAction {
                    presentationMode.wrappedValue.dismiss()
                }
            } label : {
                HStack{
                    Text("Update Product")
                    
                }
                    .font(.title3.bold())
                    .padding(12)
                    .background(Color(.tintColor))
                    .foregroundColor(.white)
                    .cornerRadius(8)
              
            }.padding(.top, 50.0)
        }
        .presentationDetents([.medium])
     
    }
}
struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView(viewModel: AddUpdateProductViewModel())
    }
}
