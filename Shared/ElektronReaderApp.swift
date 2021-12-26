//
//  ElektronReaderApp.swift
//  Shared
//
//  Created by Jackson Hu on 26/12/2021.
//

import SwiftUI

@main
struct ElektronReaderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
