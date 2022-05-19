//
//  productsListView.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 15/03/2021.


import SwiftUI

struct productsListView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userAuth: UserAuth
    @State private var showButton = false
    @StateObject var viewModel = productsViewModel()
    @State var presentAddOrderSheet = false
  
  // MARK: - UI Components
    
   
    
  private var addButton: some View {
    Button(action: { self.presentAddOrderSheet.toggle() }) {
     // Image(systemName: "plus")
        Text("Create Order")
        .foregroundColor(Color.white)
    }
  }
    
  
  private func orderRowView(order: productOrder) -> some View {
    
    NavigationLink(destination: productDetailsView(order: order)) {
      VStack(alignment: .leading) {
        
        Text("Product Name ")
          .font(.headline)
            
        
        Text(order.productName)
          .font(.subheadline)
        
        Text("Product Number ")
          .font(.headline)
        Text(order.productNumber)
          .font(.subheadline)
       
        Text("Product Price ")
          .font(.headline)
        Text(order.productPrice)
          .font(.subheadline)
       
      }
      
      
    }
  }
  
  var body: some View {
    
    NavigationView {
       
        VStack(){
         
            TitleView(Title: "Products") .onAppear(perform: {
               
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.showButton = true
                    
                }
                
            })
           
            VStack(){
                
                
                Text("Products").font(.largeTitle)
                
                
            }.padding([.leading, .top], 10).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            
     
            
             List {
               
               ForEach (viewModel.orders) { order in
                 orderRowView(order: order)
               }
               .onDelete() { indexSet in
                 viewModel.removeOrders(atOffsets: indexSet)
               }
             }
               
       //      .navigationBarTitle("Orders")
           .navigationBarItems(trailing: addButton)
             .onAppear()
             {
               print("OrdersListView appears. Subscribing to data updates.")
               self.viewModel.subscribe()
             }
             .onDisappear() {
               // By unsubscribing from the view model, we prevent updates coming in from
               // Firestore to be reflected in the UI. Since we do want to receive updates
               // when the user is on any of the child screens, we keep the subscription active!
               //
               // print("BooksListView disappears. Unsubscribing from data updates.")
               // self.viewModel.unsubscribe()
             }
             .sheet(isPresented: self.$presentAddOrderSheet) {
               productListView()
               
             }
                   
           } .edgesIgnoringSafeArea(.top)
        
       
  }
    
    
    .navigationViewStyle(StackNavigationViewStyle())
    
  }
    
}

struct productsListView_Previews: PreviewProvider {
    static var previews: some View {
        productsListView()
    }
}
