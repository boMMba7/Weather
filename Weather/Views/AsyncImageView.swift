//
//  AsyncImageView.swift
//  Weather
//
//  Created by Fábio Pontes on 02/10/2022.
//

import SwiftUI

struct AsyncImageView: View {
    
    var imageurl: String
    var width, height: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: imageurl)){ phase in
            if let image = phase.image {
                image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
            } else if phase.error != nil {
                Text("error trying to load the image")
            } else {
                ProgressView()
            }
        }
    }
}

//struct AsyncImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        AsyncImageView()
//    }
//}
