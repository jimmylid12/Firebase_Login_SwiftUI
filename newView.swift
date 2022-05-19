//
//  newView.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 31/01/2022.


import SwiftUI
import FirebaseStorage


struct newView: View {
    @State var showActionSheet = false
    @State var showImagePicker = false
    
    @State var sourceType:UIImagePickerController.SourceType = .camera
    
    @State var upload_image:UIImage?
    @State var download_image:UIImage?
    
    var body: some View {
        
        //Image
        VStack {
            HStack{
            //Uploading image
                if upload_image != nil {
                Image(uiImage: upload_image!)
                .resizable()
                .scaledToFit()
                    .frame(width:120, height:120)
            } else {
                Image(systemName: "timelapse")
                .resizable()
                .scaledToFit()
                    .frame(width:300, height:300)
            }
                Spacer()
                if download_image != nil {
                    Image(uiImage: download_image!)
                    .resizable()
                    .scaledToFit()
                        .frame(width:120, height:120)
                } else {
                    Image(systemName: "timelapse")
                    .resizable()
                    .scaledToFit()
                        .frame(width:120, height:120)
                }
            }.padding()
            //Button for image picker
            Button(action: {
                self.showActionSheet = true
            }) {
                Text("Show Image Picker")
            }.actionSheet(isPresented: $showActionSheet){
                ActionSheet(title: Text("Add a picture to your post"), message: nil, buttons: [
                    //Button1
                    
                    .default(Text("Camera"), action: {
                        self.showImagePicker = true
                        self.sourceType = .camera
                    }),
                    //Button2
                    .default(Text("Photo Library"), action: {
                        self.showImagePicker = true
                        self.sourceType = .photoLibrary
                    }),
                    
                    //Button3
                    .cancel()
                    
                ])
            }.sheet(isPresented: $showImagePicker){
                ImagePickers(image: self.$upload_image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                
            }
            
            //Button for upload
            Button(action: {
                if let thisImage = self.upload_image {
                    uploadImage(image: thisImage)
                } else {
                    print("")
                }
                
            }){
                Text("Upload Image")
            }
            
            Button(action: {
                Storage.storage().reference().child("temp").getData(maxSize: 15 * 1024 * 1024){
                    (imageData, err) in
                    if let err = err {
                        print("an error has occurred - \(err.localizedDescription)")
                    } else {
                        if let imageData = imageData {
                            self.download_image = UIImage(data: imageData)
                        } else {
                            print("couldn't unwrap image data image")
                        }
                        
                    }
                }
                
                
            }){
                Text("Download Image")
            }
        }
        
        
    }
}

func uploadImage(image:UIImage){
    if let imageData = image.jpegData(compressionQuality: 1){
        let storage = Storage.storage()
        storage.reference().child("temp").putData(imageData, metadata: nil){
            (_, err) in
            if let err = err {
                print("an error has occurred - \(err.localizedDescription)")
            } else {
                print("image uploaded successfully")
            }
        }
    } else {
        print("coldn't unwrap/case image to data")
    }
}


struct newView_Previews: PreviewProvider {
    static var previews: some View {
        newView()
    }
}
