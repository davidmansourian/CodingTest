//
//  ProfileView.swift
//  CodingTest
//
//  Created by David on 2022-11-29.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var profilePageVm = ProfilePageViewModel()
    @State private var largePhotoView: Bool = true
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(.vertical){
                    VStack{
                        Text("My Favorites")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                        ForEach(profilePageVm.likedPhotos){ imageData in
                            SingleImageView(model: imageData)
                        }
                    }
                }
            }
            .onAppear(){
                CoreDataManager.shared.fetchLikedData()
            }
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu{
                        Button {
                           largePhotoView = true
                        } label: {
                            Image(systemName: "square")
                            Text("Single View")
                        }
                        Button {
                            largePhotoView = false
                        } label: {
                            Image(systemName: "square.split.2x2")
                            Text("Grid View")
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
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
