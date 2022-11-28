//
//  ImageResultView.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import SwiftUI

struct ImageResultView: View {
    @StateObject var imageResultsVm: ImageResultsViewModel
    
    init(url: String){
        _imageResultsVm = StateObject(wrappedValue: ImageResultsViewModel(url: url))
    }
    
    var body: some View {
        ZStack{
            if imageResultsVm.isLoading{
                ProgressView()
            } else if let image = imageResultsVm.image{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                
            }
        }
    }
}

struct ImageResultView_Previews: PreviewProvider {
    static var previews: some View {
        ImageResultView(url: "https://live.staticflickr.com/65535/52523272909_6739efebdf.jpg")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
