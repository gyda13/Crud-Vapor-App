//
//  ModalType.swift
//  Crud-Vapor-App
//
//  Created by gyda almohaimeed on 07/07/1444 AH.
//

import Foundation



enum ModalType: Identifiable {
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    
case add
case update(Product)
    
}
