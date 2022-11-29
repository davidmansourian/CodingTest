//
//  LikeButtonView.swift
//  CodingTest
//
//  Created by David on 2022-11-29.
//

import SwiftUI

struct LikeButtonView: View {
    @ObservedObject var pickedImageVm: PickedImageViewModel
    var body: some View {
        ZStack{
            if pickedImageVm.isLiked{
                Image(systemName: "heart.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
            else{
                Image(systemName: "heart")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}

struct LikeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LikeButtonView(pickedImageVm: PickedImageViewModel())
    }
}
