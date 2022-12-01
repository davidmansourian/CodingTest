//
//  ProfileView.swift
//  CodingTest
//
//  Created by David on 2022-11-29.
//

import SwiftUI

struct ProfileView: View {
    private let columns = [GridItem(.adaptive(minimum: 130), spacing: 0)]
    
    @StateObject var profilePageVm = ProfilePageViewModel()
    @StateObject var searchResultVm = SearchResultsViewModel()
    
    @State var isShowing: Bool = false
    @State private var largePhotoView: Bool = true
    
    var body: some View {
        ZStack {
            NavigationStack{
                VStack{
                    ScrollView(.vertical){
                        Text("My Favorites")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        if largePhotoView{
                            theLargePhotoView
                        }
                        else{
                            theGridPhotoView
                        }
                    }
                }
                .onAppear(){
                    CoreDataManager.shared.fetchLikedData()
                }
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        toolBarLayout
                        
                    }
                }
            }
            if searchResultVm.isShowing{
                MagnifiedImageView(url: searchResultVm.pickedImageUrl, key: searchResultVm.pickedImageKey)
                    .onTapGesture {
                        withAnimation(.default){
                            searchResultVm.isShowing.toggle()
                        }
                    }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


// Large PhotoView
extension ProfileView{
    var theLargePhotoView: some View{
        VStack{
            ForEach(profilePageVm.likedPhotos){ imageData in
                Button {
                    withAnimation(.default){
                        searchResultVm.pickedImageUrl = imageData.url ?? ""
                        searchResultVm.pickedImageKey = imageData.id
                        searchResultVm.isShowing.toggle()
                    }
                } label: {
                    SingleImageView(model: imageData)
                }
            }
        }
    }
}

// Grid PhotoView
extension ProfileView{
    var theGridPhotoView: some View{
        VStack {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 0){
                ForEach(profilePageVm.likedPhotos){ searchResults in
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
}

// ToolBar-layout for profile
extension ProfileView{
    var toolBarLayout: some View{
        Button {
            withAnimation(.default){
                largePhotoView.toggle()
            }
        } label: {
            largePhotoView ?
            Image(systemName: "square.split.2x2")
                .foregroundColor(.black)
                .padding(10).background(.gray.opacity(0.2))
                .clipShape(Circle()) :
            Image(systemName : "square")
                .foregroundColor(.black)
                .padding(10).background(.gray.opacity(0.2))
                .clipShape(Circle())
        }
        
    }
}
