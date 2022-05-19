//
//  productListView.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 15/03/2021.

import SwiftUI

enum newMode {
    case new
    case edit
}

enum newAction {
    case delete
    case done
    case cancel
}


struct productListView: View {
    @State private var showButton = false
    
    
    
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    
    
    @ObservedObject var viewModel = productViewModel()
    var mode: newMode = .new
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
                        
                        TextField("Product Name", text: $viewModel.order.productName)
                        TextField("Product Number", text: $viewModel.order.productNumber)
                        TextField("Product Price", text: $viewModel.order.productPrice)
                   
                   
                        
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
struct productListView_Previews: PreviewProvider {
    static var previews: some View {
        let order = productOrder(productName: "",  productNumber: "",productPrice: "")
        let ProductViewModel = productViewModel(order: order)
        return productListView(viewModel: ProductViewModel, mode: .edit)
    }
}
