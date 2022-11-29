//
//  ImageResultView.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import SwiftUI

struct ImageResultView: View {
    @StateObject var imageResultsVm: ImageResultsViewModel
    
    init(url: String, key: String){
        _imageResultsVm = StateObject(wrappedValue: ImageResultsViewModel(url: url, key: key))
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
        ImageResultView(url: "https://live.staticflickr.com/65535/52523272909_6739efebdf.jpg", key: "Test")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
