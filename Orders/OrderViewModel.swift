


// This is how an order is uploaded to firebase


import Foundation
import Combine
import FirebaseFirestore

class OrderViewModel: ObservableObject {
  // MARK: - Public properties
  
  @Published var order: Order
  @Published var modified = false
  
  // MARK: - Internal properties
  
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Constructors
  
    init(order: Order = Order(title: "", products: "",customerName: "",customerAddress: "",customerPostCode: "",customerDelCol: "",productPrice: "",customerTelephone: "")) {
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
  
  private func addOrder(_ order: Order) {
    do {
      let _ = try db.collection("Orders").addDocument(from: order)
    }
    catch {
      print(error)
    }
  }
  
  private func updateBook(_ order: Order) {
    if let documentId = order.id {
      do {
        try db.collection("Orders").document(documentId).setData(from: order)
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
      db.collection("Orders").document(documentId).delete { error in
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
