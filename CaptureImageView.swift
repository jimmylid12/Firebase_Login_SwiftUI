//
//  ImagePicker.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 08/03/2021.
//  Copyright © 2021 Bala. All rights reserved.
//

import SwiftUI

struct CaptureImageView {
  
  /// MARK: - Properties
  @Binding var isShown: Bool
  @Binding var image: Image?
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image)
  }
}

extension CaptureImageView: UIViewControllerRepresentable {
  func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    /// Default is images gallery. Un-comment the next line of code if you would like to test camera
//    picker.sourceType = .camera
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<CaptureImageView>) {
    
  }
}


//struct ImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CaptureImageView()
//    }
//}
