//
//  PickedPhotoView.swift
//  CodingTest
//
//  Created by David on 2022-11-29.
//

import SwiftUI

struct PickedPhotoView: View {
    @StateObject var imageResultsVm: ImageResultsViewModel
    
    init(url: String, key: String){
        _imageResultsVm = StateObject(wrappedValue: ImageResultsViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.9)
                .edgesIgnoringSafeArea(.all)
            
            Image(systemName: "heart")
                .foregroundColor(.white)
            
            VStack{
                
                if imageResultsVm.isLoading{
                    ProgressView()
                } else if let image = imageResultsVm.image{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 380)
                        .cornerRadius(15)
                }
                
                VStack{
                    Text("This is a test text for images. The image title will ideally be shown beneath the picture along with image related tags The thought is that the user can browse more photos like this by pressing the tag")
                        .padding(.top, 10)
                        .padding(.horizontal, 10)
                        .foregroundColor(.white)
                        .layoutPriority(1)
                    Text("#mountain #snow #white #alps #snowboard #goals")
                        .padding(.top, 10)
                        .foregroundColor(.blue)
                    
                }
            }
            .background(
                Rectangle()
                    .fill(Color.white.opacity(0.2))
            )
            .cornerRadius(15)
            .padding()
        }
    }
}

struct PickedPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PickedPhotoView(url: "https://live.staticflickr.com/8245/8674348283_78024e360a.jpg", key: "Test")
    }
}
