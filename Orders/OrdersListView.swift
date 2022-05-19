


// This page is what displays all of the order after they are created




import SwiftUI

@available(iOS 14.0, *)
struct OrdersListView: View {
  // MARK: - State
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userAuth: UserAuth
    @State private var showButton = false
    @StateObject var viewModel = OrdersViewModel()
    @State var presentAddOrderSheet = false
  
  // MARK: - UI Components
    
   
    
  private var addButton: some View {
    Button(action: { self.presentAddOrderSheet.toggle() }) {
     // Image(systemName: "plus")
        Text("Create Order")
        .foregroundColor(Color.white)
    }
  }
    
  
  private func orderRowView(order: Order) -> some View {
    
    NavigationLink(destination: OrderDetailsView(order: order)) {
      VStack(alignment: .leading) {
        
        Text("Order ")
          .font(.headline)
        
        Text(order.title)
          .font(.subheadline)
        
        Text("Product ")
          .font(.headline)
        Text(order.products)
          .font(.subheadline)
       
        Text("Price ")
          .font(.headline)
        Text(order.productPrice)
          .font(.subheadline)
        Text("Name ")
          .font(.headline)
        Text(order.customerName)
          .font(.subheadline)
      }
        Spacer()
        VStack(alignment: .leading){
            
            Text("Address")
              .font(.headline)
        Text(order.customerAddress)
          .font(.subheadline)
            
            Text("PostCode ")
              .font(.headline)
        Text(order.customerPostCode)
          .font(.subheadline)
      
            Text("Del/Col ")
              .font(.headline)
         Text(order.customerDelCol)
          .font(.subheadline)
        
            Text("PhoneNumber ")
              .font(.headline)
        Text(order.customerTelephone)
         .font(.subheadline)
        
    }
      
    }
  }
  
  var body: some View {
    
    NavigationView {
       
        VStack(){
         
            TitleView(Title: "Order List") .onAppear(perform: {
               
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.showButton = true
                    
                }
                
            })
           
            VStack(){
                
                
                Text("Orders").font(.largeTitle)
                
                
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
               OrderListView()
               
             }
                   
           } .edgesIgnoringSafeArea(.top)
        
       
  }
    
    
    .navigationViewStyle(StackNavigationViewStyle())
    
  }
    
}
struct OrdersListView_Previews: PreviewProvider {
  static var previews: some View {
    OrdersListView()
  }
}
