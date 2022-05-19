




// This is the page which allows you to update the app which firebase will then deal with



import Foundation
import Combine
import FirebaseFirestore

class OrdersViewModel: ObservableObject {
  @Published var orders = [Order]()
  
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
      listenerRegistration = db.collection("Orders").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
        
        self.orders = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Order.self)
        }
      }
    }
  }
  
  func removeOrders(atOffsets indexSet: IndexSet) {
    let orders = indexSet.lazy.map { self.orders[$0] }
    orders.forEach { order in
      if let documentId = order.id {
        db.collection("Orders").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }

  
}
