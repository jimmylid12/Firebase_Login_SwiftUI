//
//  FirebaseImage.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 16/01/2022.
//  Copyright © 2022 Bala. All rights reserved.
//
import SwiftUI
import Combine

import FirebaseStorage
final class Loader : BindableObject {
    let didChange = PassthroughSubject<Data?, Never>()
    var data: Data? = nil {
        didSet { didChange.send(data) }
    }
    
    init(_ id: String){
        let url = "images/thumb-sm@\(id)"
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }
            
            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}

let placeholder = UIImage(named: "placeholder.jpg")!

struct FirebaseImage : View {
    
    init(id: String) {
        self.imageLoader = Loader(id)
    }
    
    @ObjectBinding private var imageLoader : Loader
    
    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }
  
    var body: some View {
        Image(uiImage: image ?? placeholder)
            .resizable()
            .aspectRatio(contentMode: .fill)
        
    }
}

#if DEBUG
struct FirebaseImage_Previews : PreviewProvider {
    static var previews: some View {
        FirebaseImage(id: "random")
    }
}
#endif
