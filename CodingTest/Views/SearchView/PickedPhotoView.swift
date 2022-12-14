//
//  PickedPhotoView.swift
//  CodingTest
//
//  Created by David on 2022-11-29.
//

import SwiftUI

struct PickedPhotoView: View {
    @StateObject var pickedImageVm = PickedImageViewModel()
    @StateObject var imageResultsVm: ImageResultsViewModel
    @State var isButtonFilled: Bool = false
    
    init(url: String, key: String){
        _imageResultsVm = StateObject(wrappedValue: ImageResultsViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.9)
                .edgesIgnoringSafeArea(.all)

            VStack{
                VStack{
                    if imageResultsVm.isLoading{
                        ProgressView()
                    } else if let image = imageResultsVm.image{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 370)
                            .cornerRadius(15)
                    }
                    
                    VStack{
                        Text(imageResultsVm.fullImageString)
                            .padding(.top, 10)
                            .padding(.horizontal, 10)
                            .foregroundColor(.white)
                    }
                }
                .background(
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                )
                .cornerRadius(15)
                .padding()
                .onTapGesture(count: 2){
                    pickedImageVm.handleImage()
                    isButtonFilled.toggle()
                }
                
                likeButton

            }
            .offset(y: -60)
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear{
            pickedImageVm.likedUrlString = imageResultsVm.urlString
            pickedImageVm.likedKeyString = imageResultsVm.imageKey
            isButtonFilled = pickedImageVm.isLiked
        }
    }

}

struct PickedPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PickedPhotoView(url: "https://live.staticflickr.com/8245/8674348283_78024e360a.jpg", key: "Test")
    }
}



// Like Button (should be a general reusable likebutton. Will fix if time 
extension PickedPhotoView{
    var likeButton: some View{
        Button {
            isButtonFilled.toggle()
            pickedImageVm.handleImage()
        } label: {
            if isButtonFilled{
                Image(systemName: "heart.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            } else if !isButtonFilled{
                Image(systemName: "heart")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}
