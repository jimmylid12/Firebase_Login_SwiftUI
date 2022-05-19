////
////  productsView.swift
////  Firebase_Login_SwiftUI
////
////  Created by James Liddle on 16/03/2021.

//import SwiftUI
//import Firebase
//
//struct productsView: View {
//    @ObservedObject var data = getDatas()
//    
//    var body: some View {
//       
//        NavigationView{
//            
//            ZStack(alignment: .top){
//                
//                GeometryReader{_ in
//                    
//                  
//                    Text("Home")
//                    
//                }.background(Color("Color").edgesIgnoringSafeArea(.all))
//                
//                CustomSearchBarr(data: self.$data.datass).padding(.top)
//                
//            }.navigationBarTitle("")
//            .navigationBarHidden(true)
//        }
//    }
//}
//struct productsView_Previews: PreviewProvider {
//    static var previews: some View {
//        productsView()
//    }
//}
//struct CustomSearchBarr : View {
//    
//    @State var txt = ""
//    @Binding var data : [dataTyp]
//    
//    var body : some View{
//        
//        VStack(spacing: 0){
//            
//            HStack{
//                
//                TextField("Search", text: self.$txt)
//                
//                if self.txt != ""{
//                    
//                    Button(action: {
//                        
//                        self.txt = ""
//                        
//                    }) {
//                        
//                        Text("Cancel")
//                    }
//                    .foregroundColor(.black)
//                    
//                }
//
//            }.padding()
//            
//            if self.txt != ""{
//                
//                if  self.data.filter({$0.productName.lowercased().contains(self.txt.lowercased())}).count == 0{
//                    
//                    Text("No Results Found").foregroundColor(Color.black.opacity(0.5)).padding()
//                }
//                else{
//                    
//                    List(self.data.filter{$0.productName.lowercased().contains(self.txt.lowercased())}){i in
//                            
//                    NavigationLink(destination: Detaill(data: i)) {
//                        
//                      
//                        Text(i.productName)
//                      
//                        
//                    }
//                            
//                        
//                    }.frame(height: UIScreen.main.bounds.height / 5)
//                }
//
//            }
//            
//            
//        }.background(Color.white)
//        .padding()
//    }
//}
//
//class getDatas : ObservableObject{
//    
//    @Published var datass = [dataTyp]()
//    
//    init() {
//        
//        let db = Firestore.firestore()
//        
//        db.collection("Products").getDocuments { (snap, err) in
//            
//            if err != nil{
//                
//                print((err?.localizedDescription)!)
//                return
//            }
//            
//            for i in snap!.documents{
//                
//                let id = i.documentID
//                let productName = i.get("title") as! String
//                let productNumber = i.get("title") as! String
//                let productPrice = i.get("title") as! String
//              
//          
//                
//                self.datass.append(dataTyp(id: id, productName: productName, productNumber: productNumber,productPrice: productPrice))
//            }
//        }
//    }
//}
//
//struct dataTyp: Identifiable {
//    
//    var id : String
//    var productName: String
//    var productNumber: String
//    var productPrice: String
//    
//    
//    
//    
//}
//
//
//struct Detaill : View {
//    
//    var data : dataTyp
//    
//    var body : some View{
//      
//
//        Text("Product price")
//            .font(.largeTitle).fontWeight(.light)
//        Text(data.productName)
//            .font(.largeTitle).fontWeight(.light)
//      
//
//    }
//}
