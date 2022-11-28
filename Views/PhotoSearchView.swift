//
//  PhotoSearchView.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import SwiftUI

struct PhotoSearchView: View {
    private let columns = [GridItem(.adaptive(minimum: 100), spacing: 0)]
    @StateObject var searchResultVm = SearchResultsViewModel()
    @StateObject var searchAPI = APILoaderService.shared
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns, alignment: .leading, spacing: 0){
                    ForEach(searchResultVm.systemSearchResult?.photo ?? []){ searchResults in
                        Image(searchResults.id)
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .border(Color.red)
                    }
                }
                .searchable(text: $searchAPI.searchString)
            }
        }
    }
}

struct PhotoSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSearchView()
    }
}
