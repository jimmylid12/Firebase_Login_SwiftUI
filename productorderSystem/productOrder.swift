//
//  productOrder.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 15/03/2021.

import Foundation
import FirebaseFirestoreSwift

struct productOrder:  Identifiable, Codable {
    @DocumentID var id: String?
    var productName: String
    var productNumber: String
    var productPrice: String
  
    
    enum CodingKeys: String, CodingKey {
      case id
      case productName
      case productNumber
      case productPrice
 
    }
  }
