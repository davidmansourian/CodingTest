//
//  CodingTestApp.swift
//  CodingTest
//
//  Created by David Mansourian on 2022-11-28.
//

import SwiftUI

@main
struct CodingTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
