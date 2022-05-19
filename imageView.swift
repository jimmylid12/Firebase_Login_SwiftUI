//
//  imageView.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 08/03/2021.
//  Copyright © 2021 Bala. All rights reserved.
//

import SwiftUI
import FirebaseStorage
import Combine

let FILE_NAME = "images/imageFileTest.jpg"

struct imageView: View {
   
    @State var shown = false
    @State var imageURL = ""
    var body: some View {
        VStack {
            if imageURL != "" {
                FirebaseImageView(imageURL: imageURL)
            }
            
            Button(action: { self.shown.toggle() }) {
                Text("Upload Image").font(.title).bold()
            }.sheet(isPresented: $shown) {
                imagePicker(shown: self.$shown,imageURL: self.$imageURL)
                }.padding(10).background(Color.purple).foregroundColor(Color.white).cornerRadius(20)
        }.onAppear(perform: loadImageFromFirebase).animation(.spring())
    }
    
    func loadImageFromFirebase() {
        let storage = Storage.storage().reference(withPath: FILE_NAME)
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download success")
            self.imageURL = "\(url!)"
        }
    }
}


struct imageView_Previews: PreviewProvider {
    static var previews: some View {
        imageView()
    }
}
