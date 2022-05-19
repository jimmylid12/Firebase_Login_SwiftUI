//
//  searchbarr.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 31/01/2022.


import SwiftUI
import Firebase

struct searchbarr: View {
    @ObservedObject var data = getData()
    
    var body: some View {
       
        NavigationView{
            
            ZStack(alignment: .top){
                
                GeometryReader{_ in
                    
                    // Home View....
                    Text("Home")
                    
                }.background(Color("Color").edgesIgnoringSafeArea(.all))
                
                CustomSearchBarr(data: self.$data.datas).padding(.top)
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct searchbarr_Previews: PreviewProvider {
    static var previews: some View {
        searchbarr()
    }
}

struct CustomSearchBarr : View {
    
    @State var txt = ""
    @Binding var data : [dataType]
    
    var body : some View{
        
        VStack(spacing: 0){
            
            HStack{
                
                TextField("Search", text: self.$txt)
                
                if self.txt != ""{
                    
                    Button(action: {
                        
                        self.txt = ""
                        
                    }) {
                        
                        Text("Cancel")
                    }
                    .foregroundColor(.black)
                    
                }

            }.padding()
            
            if self.txt != ""{
                
                if  self.data.filter({$0.customerName.lowercased().contains(self.txt.lowercased())}).count == 0{
                    
                    Text("No Results Found").foregroundColor(Color.black.opacity(0.5)).padding()
                }
             
                
                
                
                
               else{
                    
                List(self.data.filter{$0.customerName.lowercased().contains(self.txt.lowercased())}){i in
                            
                    NavigationLink(destination: Detail(data: i)) {
                        
                       
                        Text(i.customerName)
                     
                       
                    
                    }
                            
                        
                    }.frame(height: UIScreen.main.bounds.height / 5)
                }

            }
            
            
        }.background(Color.white)
        .padding()
    }
}

class getData : ObservableObject{
    
    @Published var datas = [dataType]()
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("Orders").getDocuments { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                
               let id = i.documentID

                          let products = i.get("title") as! String
                          let customerName = i.get("title") as! String
                          let  customerAddress = i.get("title") as! String
                          let  customerPostCode = i.get("title") as! String
                          let  customerDelCol = i.get("title") as! String
                    //      let  productPrice = i.get("title") as! String
                          let  customerTelephone = i.get("title") as! String
                
                self.datas.append(dataType(id: id,  products: products,customerName: customerName,customerAddress: customerAddress,customerPostCode: customerPostCode,customerDelCol: customerDelCol,customerTelephone: customerTelephone))
            }
        }
    }
}

struct dataType : Identifiable {
    var id : String
  
     //  var  title : String
        var products : String
        var customerName : String
        var customerAddress : String
        var customerPostCode : String
        var customerDelCol : String
        var customerTelephone : String
   
}

struct Detail : View {
    
    var data : dataType
    
    var body : some View{
        Text("customer Name")
        Text(data.customerName)
        Text("customer adress")
        Text(data.customerAddress)
        Text(data.customerPostCode)
        Text(data.customerDelCol)
        Text(data.customerTelephone)
    }
}
