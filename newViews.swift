//
//  newViews.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 09/03/2021.

import SwiftUI
import FirebaseStorage
import Combine

let FILE_NAME = "images/imageFileTest.jpg"


struct newViews: View {
    @State var shown = false
        @State var imageURLList = [String]()
    @State private var showingAlert = false
      

            var body: some View {
                VStack{
                          Button(action: { self.shown.toggle() }) {
                              Text("Upload Image").font(.title).bold()
                          }.sheet(isPresented: $shown) {
                              imagePicker(shown: self.$shown,imageURLList: self.$imageURLList)
                               }.padding(10).background(Color.blue).foregroundColor(Color.white).cornerRadius(20)
                          
                   
                      }.onAppear(perform: listOfImageFile).animation(.spring())
              
                    
                  }
    
            
    func listOfImageFile() {
           let storageReference = Storage.storage().reference().child("images/")
           storageReference.listAll { (result, error) in
             if error != nil {
                 // Handle any errors
                 print((error?.localizedDescription)!)
                 return
             }
               
             for prefix in result.prefixes {
         
             
               
                
               print("prefix is \(prefix)")
             }


           }
        
       }

        }

struct newViews_Previews: PreviewProvider {
    static var previews: some View {
        newViews()
    }
}
