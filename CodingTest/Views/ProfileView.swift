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
    @State private var largePhotoView: Bool = true
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(.vertical){
                    if largePhotoView{
                        VStack{
                            Text("My Favorites")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            
                            ForEach(profilePageVm.likedPhotos){ imageData in
                                SingleImageView(model: imageData)
                            }
                        }
                    }
                    else{
                        VStack {
                            Text("My Favorites")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            LazyVGrid(columns: columns, alignment: .leading, spacing: 0){
                                ForEach(profilePageVm.likedPhotos){ searchResults in
                                    Button {
                                        withAnimation(.default){
                                        }
                                    } label: {
                                        SingleImageView(model: searchResults)
                                    }
                                }
                            }
                        }
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
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
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
            Image(systemName: "square")
                .foregroundColor(.black)
                .padding(10).background(.gray.opacity(0.2))
                .clipShape(Circle()) :
            Image(systemName : "square.split.2x2")
                .foregroundColor(.black)
                .padding(10).background(.gray.opacity(0.2))
                .clipShape(Circle())
        }
        
    }
}
