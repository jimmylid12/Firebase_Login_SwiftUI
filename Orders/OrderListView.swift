


// This page allows you to create an order


import SwiftUI

enum Mode {
    case new
    case edit
}

enum Action {
    case delete
    case done
    case cancel
}

struct OrderListView: View {
    
    @State private var showButton = false
    
    
    
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    
    
    @ObservedObject var viewModel = OrderViewModel()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    
    
    
    var cancelButton: some View {
        Button(action: { self.handleCancelTapped() }) {
            Text("Cancel")
                .foregroundColor(.white)
        }
    }
    
    var saveButton: some View {
        Button(action: { self.handleDoneTapped() }) {
            Text(mode == .new ? "Create Order" : "Save")
        }
        .disabled(!viewModel.modified)
    }
    var body: some View {
        
        NavigationView {
            VStack(){
                
                TitleView(Title: "") .onAppear(perform: {
                    
                    
                    
                })
                
                VStack(){
                    
                    
                    
                    Text("Orders").font(.largeTitle)
                    
                    
                }.padding([.leading, .top], 10).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                Form {
                    Section(header: Text("Order")) {
                        
                        TextField("Ordernumber", text: $viewModel.order.title)
                        TextField("Product", text: $viewModel.order.products)
                        TextField("Price", text: $viewModel.order.productPrice)
                        TextField("CustomerName", text: $viewModel.order.customerName)
                        TextField("CustomerAddress", text: $viewModel.order.customerAddress)
                        TextField("CustomerPostCode", text: $viewModel.order.customerPostCode)
                        TextField("Collection/Delivery ", text: $viewModel.order.customerDelCol)
                        TextField("Telephone`Number ", text: $viewModel.order.customerTelephone)
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    if mode == .edit {
                        Section {
                            Button("Delete order") { self.presentActionSheet.toggle() }
                                .foregroundColor(.red)
                        }
                    }
                }
                
            
                .navigationBarItems(
                    leading: cancelButton,
                    trailing: saveButton
                )
                
                .actionSheet(isPresented: $presentActionSheet) {
                    ActionSheet(title: Text("Are you sure?"),
                                buttons: [
                                    .destructive(Text("Delete book"),
                                                 action: { self.handleDeleteTapped() }),
                                    .cancel()
                                    
                                    
                                    
                                ])
                    
                    
                }
                
            }.edgesIgnoringSafeArea(.top)
            
            
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
        
    }
    
    
    
    // MARK: - Action Handlers
    
    func handleCancelTapped() {
        self.dismiss()
    }
    
    func handleDoneTapped() {
        self.viewModel.handleDoneTapped()
        self.dismiss()
    }
    
    func handleDeleteTapped() {
        viewModel.handleDeleteTapped()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        let order = Order(title: "Order", products: "products",customerName: "customerName",customerAddress: "customerAddress",customerPostCode: "customerPostCode",customerDelCol: "customerDelCol",productPrice: "productPrice",customerTelephone: "telephone number")
        let orderViewModel = OrderViewModel(order: order)
        return OrderListView(viewModel: orderViewModel, mode: .edit)
    }
}
