//
//  TabBar.swift
//  Crud-Vapor-App
//
//  Created by gyda almohaimeed on 11/07/1444 AH.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
                  ProductList()
                       .tabItem {
                           Label("Products", systemImage: "shippingbox.fill")
                              
                       }

                   ProductSummery()
                       .tabItem {
                           Label("Products Summery", systemImage: "chart.line.uptrend.xyaxis")
                              
                       }
        } 
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
