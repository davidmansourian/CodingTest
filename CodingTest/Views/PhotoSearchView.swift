//
//  PhotoSearchView.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import SwiftUI

struct PhotoSearchView: View {
    @State private var isShowing: Bool = false
    @State private var isNotShowing: Bool = false
    private let columns = [GridItem(.adaptive(minimum: 100), spacing: 0)]
    @StateObject var searchResultVm = SearchResultsViewModel()
    @StateObject var searchAPI = APILoaderService.shared
    var body: some View {
        ZStack {
            NavigationStack{
                ScrollView{
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 0){
                        ForEach(searchResultVm.photosResults){ searchResults in
                            Button {
                                withAnimation(.default){
                                    isShowing.toggle()
                                }
                            } label: {
                                SingleImageView(model: searchResults)
                            }
                        }
                    }
                }
                .searchable(text: $searchAPI.searchString).autocorrectionDisabled()
            }
            if isShowing{
                PickedPhotoView(url: "https://live.staticflickr.com/7360/27683548156_7fa2d3e773.jpg", key: "")
                    .onTapGesture {
                        isShowing.toggle()
                    }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct PhotoSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSearchView()
    }
}
