//
//  productsViewModel.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 15/03/2021.

import Foundation
import Combine
import FirebaseFirestore
import SwiftUI

class productsViewModel:ObservableObject {
    @Published var orders = [productOrder]()
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    deinit {
      unsubscribe()
    }
    
    func unsubscribe() {
      if listenerRegistration != nil {
        listenerRegistration?.remove()
        listenerRegistration = nil
      }
    }
    
    func subscribe() {
      if listenerRegistration == nil {
        listenerRegistration = db.collection("Products").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
          }
          
          self.orders = documents.compactMap { queryDocumentSnapshot in
            try? queryDocumentSnapshot.data(as: productOrder.self)
          }
        }
      }
    }
    
    func removeOrders(atOffsets indexSet: IndexSet) {
      let orders = indexSet.lazy.map { self.orders[$0] }
      orders.forEach { order in
        if let documentId = order.id {
          db.collection("Products").document(documentId).delete { error in
            if let error = error {
              print("Unable to remove document: \(error.localizedDescription)")
            }
          }
        }
      }
    }

    
  }
