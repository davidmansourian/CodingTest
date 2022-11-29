//
//  ProfileView.swift
//  CodingTest
//
//  Created by David on 2022-11-29.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                VStack{
                    Text("My Favorites")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
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
