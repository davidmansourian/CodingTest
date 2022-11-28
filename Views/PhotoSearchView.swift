//
//  PhotoSearchView.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import SwiftUI

struct PhotoSearchView: View {
    @StateObject var searchResultVm = SearchResultsViewModel()
    var body: some View {
        ZStack{
            List{
                ForEach(searchResultVm.photoSystemResult?.photo ?? []){ theResults in
                    Text(theResults.title)
                        .font(.largeTitle)
                        .foregroundColor(.black)
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
