//
//  PhotoSearchView.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import SwiftUI

struct PhotoSearchView: View {
    private let columns = [GridItem(.adaptive(minimum: 130), spacing: 0)]
    @StateObject var searchResultVm = SearchResultsViewModel()
    @StateObject var searchAPI = APILoaderService.shared
    
    @State var isShowing: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack{
                ScrollView{
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 0){
                        ForEach(searchResultVm.photosResults){ searchResults in
                            Button {
                                withAnimation(.default){
                                    searchResultVm.pickedImageUrl = searchResults.url ?? ""
                                    searchResultVm.pickedImageKey = searchResults.id
                                    searchResultVm.isShowing.toggle()
                                }
                            } label: {
                                SingleImageView(model: searchResults)
                            }
                        }
                    }
                }
                
            }
            .searchable(text: $searchAPI.searchString)
            if searchResultVm.isShowing{
                PickedPhotoView(url: searchResultVm.pickedImageUrl, key: searchResultVm.pickedImageKey)
                    .onTapGesture {
                        withAnimation(.default){
                            searchResultVm.isShowing.toggle()
                        }
                    }
            }
        }
    }
}

struct PhotoSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSearchView()
    }
}
