//
//  MagnifiedImageView.swift
//  CodingTest
//
//  Created by David on 2022-11-30.
//

import SwiftUI

struct MagnifiedImageView: View {
    @StateObject var imageResultsVm: ImageResultsViewModel
    @StateObject var pickedImageVm = PickedImageViewModel()
    @State var isButtonFilled: Bool = false
    
    init(url: String, key: String){
        _imageResultsVm = StateObject(wrappedValue: ImageResultsViewModel(url: url, key: key))
    }
    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .edgesIgnoringSafeArea(.all)
            VStack{
                if imageResultsVm.isLoading{
                    ProgressView()
                } else if let image = imageResultsVm.image{
                    Image(uiImage: image)
                }
                likeButton
            }
            .onTapGesture(count: 2){
                pickedImageVm.handleImage()
                isButtonFilled.toggle()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear{
            pickedImageVm.likedUrlString = imageResultsVm.urlString
            pickedImageVm.likedKeyString = imageResultsVm.imageKey
            isButtonFilled = pickedImageVm.isLiked
        }
        .onDisappear{
            withAnimation{
                CoreDataManager.shared.fetchLikedData()
            }
        }
    }
}

struct MagnifiedImageView_Previews: PreviewProvider {
    static var previews: some View {
        MagnifiedImageView(url: "https://live.staticflickr.com/8219/8286657525_a6a0ce78e4.jpg", key: "1")
    }
}



// Like Button (should be a general reusable likebutton. Will fix if time 
extension MagnifiedImageView{
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
