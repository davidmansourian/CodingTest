//
//  MainTabView.swift
//  CodingTest
//
//  Created by David on 2022-11-29.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedView = 0
    var body: some View {
        TabView(selection: $selectedView){
            PhotoSearchView()
                .onTapGesture {
                    self.selectedView = 0
                }
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.tag(0)
            
            ProfileView()
                .onTapGesture {
                    self.selectedView = 1
                }
                .tabItem{
                    Image(systemName: "figure.stand")
                    Text("Me")
                }.tag(1)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
