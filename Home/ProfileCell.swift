//
//  ProfileCell.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 16/01/2022.
//  Copyright © 2022 Bala. All rights reserved.
//

import SwiftUI


import UIKit
//import SDWebImageSwiftUI
import FirebaseStorage

struct ProfileCell: View {
    let profile: Profile
    @State var urlString: String = ""
    var body: some View {
        ZStack {
            WebImage(url: URL(string: self.urlString))
                .resizable()
                .placeholder {
                    Image("profile")
                        .resizable()
            }
            .animation(.easeInOut(duration: 0.5))
            .transition(.fade)
            .scaledToFill()

            VStack {
                Spacer()
                Text(profile.name)
                    .font(Font.system(size: 20.0).bold())
                    .frame(maxWidth: .infinity, maxHeight: 32)
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    .opacity(0.8)
            }
        }.onAppear {
            self.featchImageUrl()
        }
    }

    func featchImageUrl() {
        let storage = Storage.storage()
        let pathReference = storage.reference(withPath: "character/\(profile.id)/profile.png")
        pathReference.downloadURL { url, error in
            if let error = error {
                // Handle any errors
                print(error)
            } else {
                guard let urlString = url?.absoluteString else {
                    return
                }
                self.urlString = urlString
            }
        }
    }
}
