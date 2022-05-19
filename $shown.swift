//
//  testing.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 04/03/2021.
//  Copyright © 2021 Bala. All rights reserved.
//

import SwiftUI
import FirebaseStorage

struct testing: View {
    @State var showActionSheet = false
        @State var showImagePicker = false
        
        @State var sourceType:UIImagePickerController.SourceType = .camera
        
        @State var upload_image:UIImage?
        @State var download_image:UIImage?
        
        @State private var showsAlert = false
    @State var shown = false
    @State var imageURL = ""
        
        var body: some View {
           
            
          
            VStack {
                Text("Please upload your photos here!")
                HStack{
             
                    if upload_image != nil {
                    Image(uiImage: upload_image!)
                    .resizable()
                    .scaledToFit()
                        .frame(width:120, height:120, alignment: .center)
                } else {
                    Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:200, height:200, alignment: .center)
                }
     
                }.padding()
               
                Button(action: {
                    self.showActionSheet = true
                }) {
                    Text("Choose...")
                }.actionSheet(isPresented: $showActionSheet){
                    ActionSheet(title: Text("Choose from camera or photo library..."), message: nil, buttons: [
                        //Button1
                        
                        .default(Text("Camera"), action: {
                            self.showImagePicker = true
                            self.sourceType = .camera
                        }),
                      
                        .default(Text("Photo Library"), action: {
                            self.showImagePicker = true
                            self.sourceType = .photoLibrary
                        }),
                        
                       
                        .cancel()
                        
                    ])
                }.sheet(isPresented: $shown){
                    imagePicker(shown: self.$shown,imageURL: self.$imageURL)
                    
                }
                
                
                
                
                
                
            
                Button(action: {
                   
                    if let thisImage = self.upload_image {
                        uploadImage(image: thisImage)
                     
                        
                    } else {
                        
                        print("")
                    }
                    
                     
                }) {
                  
                    Text("Submit")
                     
                    }
                }
     
            }
            
            
        }
        func uploadImage(image:UIImage){
            
            let imageName = "image1"
            let folderName = "folder1"
            let path = "\(folderName)/\(imageName)"
            if let imageData = image.jpegData(compressionQuality: 1){
                
                let storage = Storage.storage()
                
                storage.reference(withPath: path).putData(imageData, metadata: nil){
                    (_, err) in
                    if let err = err {
                     print("an error has occurred - \(err.localizedDescription)")
           }
                    }
               
                }
            }

        
     

struct testing_Previews: PreviewProvider {
    static var previews: some View {
        testing()
    }
}
