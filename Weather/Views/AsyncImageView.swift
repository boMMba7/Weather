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
        // download image from server using url,
        //just render the image after donload the image
        // iff bad link or no internet connection show a error message
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

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(imageurl: "", width: 100, height: 100)
    }
}
