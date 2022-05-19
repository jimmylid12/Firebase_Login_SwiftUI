//
//  productDetailsView.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 15/03/2021.


import SwiftUI

struct productDetailsView: View {
    
        // MARK: - State
        @State private var showButton = false
        @Environment(\.presentationMode) var presentationMode
        @State var presentEditOrderSheet = false
        var order: productOrder
        
        private func editButton(action: @escaping () -> Void) -> some View {
            Button(action: { action() }) {
                Text("Edit")
                    .foregroundColor(.white)
            }
        }
        
        var body: some View {
            
        VStack(){
                
                TitleView(Title: "Products") .onAppear(perform: {
                    
                    withAnimation(.easeInOut(duration: 0.5)) {
                        
                        
                    }
                    
                })
                
                VStack(){
                    
                    
                    Text("Products").font(.largeTitle)
                    
                }.padding([.leading, .top], 10).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                
                
                
                Form {
                    Section() {
                      
                        Text(order.productName)
                        Text(order.productNumber)
                        Text(order.productPrice)
                   
                    }
                    
               
                    
                    
                    
                    
                }
               
                .navigationBarItems(trailing: editButton {
                    self.presentEditOrderSheet.toggle()
                })
                .onAppear() {
                    print("OrderDetailsView.onAppear() for \(self.order.productName)")
                }
                .onDisappear() {
                    print("OrderDetailsView.onDisappear()")
                }
                .sheet(isPresented: self.$presentEditOrderSheet) {
                    productListView(viewModel: productViewModel(order: order), mode: .edit) { result in
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
struct productDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let order = productOrder(productName: "",  productNumber: "",productPrice: "")
        return
            NavigationView {
                productDetailsView(order: order)
            }
    }
}
