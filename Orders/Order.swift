

import Foundation
import FirebaseFirestoreSwift

struct Order: Identifiable, Codable {
  @DocumentID var id: String?
  var title: String
  var products: String
  var customerName: String
  var customerAddress: String
  var customerPostCode: String
  var customerDelCol: String
  var productPrice: String
  var customerTelephone: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case products
    case customerName
    case customerAddress
    case customerPostCode
    case customerDelCol
    case productPrice
    case customerTelephone
  }
}
