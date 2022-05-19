//
//  productViewModel.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 15/03/2021.


import SwiftUI
import Foundation
import Combine
import FirebaseFirestore

class productViewModel:  ObservableObject {
    @Published var order: productOrder
    @Published var modified = false
    
    // MARK: - Internal properties
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructors
    
      init(order: productOrder = productOrder(productName: "",  productNumber: "",productPrice: "")) {
      self.order = order
      
      self.$order
        .dropFirst()
        .sink { [weak self] order in
          self?.modified = true
        }
        .store(in: &self.cancellables)
    }
    
    // MARK: - Firestore
    
    private var db = Firestore.firestore()
    
    private func addOrder(_ order: productOrder) {
      do {
        let _ = try db.collection("Products").addDocument(from: order)
      }
      catch {
        print(error)
      }
    }
    
    private func updateBook(_ order: productOrder) {
      if let documentId = order.id {
        do {
          try db.collection("Products").document(documentId).setData(from: order)
        }
        catch {
          print(error)
        }
      }
    }
    
    private func updateOrAddOrder() {
      if let _ = order.id {
        self.updateBook(self.order)
      }
      else {
        addOrder(order)
      }
    }
    
    private func removeOrder() {
      if let documentId = order.id {
        db.collection("Products").document(documentId).delete { error in
          if let error = error {
            print(error.localizedDescription)
          }
        }
      }
    }
    
    // MARK: - UI handlers
    
    func handleDoneTapped() {
      self.updateOrAddOrder()
    }
    
    func handleDeleteTapped() {
      self.removeOrder()
    }
    
  }
