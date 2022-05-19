


//Allows you to edit an order


import SwiftUI

struct OrderDetailsView: View {
    // MARK: - State
    @State private var showButton = false
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditOrderSheet = false
    var order: Order
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Edit")
                .foregroundColor(.white)
        }
    }
    
    var body: some View {
        
    VStack(){
            
            TitleView(Title: "Orders") .onAppear(perform: {
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    
                    
                }
                
            })
            
            VStack(){
                
                
                Text("Orders").font(.largeTitle)
                
            }.padding([.leading, .top], 10).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            
            
            
            Form {
                Section() {
                   
                    Text(order.title)
                
                    Text(order.products)
                    Text(order.productPrice)
                    Text(order.customerName)
                    Text(order.customerAddress)
                    Text(order.customerPostCode)
                    Text(order.customerDelCol)
                    Text(order.customerTelephone)
                }
                
                
            }
           
            .navigationBarItems(trailing: editButton {
                self.presentEditOrderSheet.toggle()
            })
            .onAppear() {
                print("OrderDetailsView.onAppear() for \(self.order.title)")
            }
            .onDisappear() {
                print("OrderDetailsView.onDisappear()")
            }
            .sheet(isPresented: self.$presentEditOrderSheet) {
                OrderListView(viewModel: OrderViewModel(order: order), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        
        .navigationViewStyle(StackNavigationViewStyle())
    }

}

struct OrderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let order = Order(title: "",  products: "",customerName: "",customerAddress: "",customerPostCode: "",customerDelCol: "",productPrice:"",customerTelephone:"")
        return
            NavigationView {
                OrderDetailsView(order: order)
            }
    }
}
