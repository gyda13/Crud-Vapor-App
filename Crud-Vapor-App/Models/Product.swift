//
//  Product.swift
//  Crud-Vapor-App
//
//  Created by gyda almohaimeed on 07/07/1444 AH.
//

import Foundation


struct Product: Identifiable, Codable {
    let id: UUID?
    var name: String
    var actual_price: Double
    var profit_price: Double
    var work_price: Double
    var quantity: Int
   
}
