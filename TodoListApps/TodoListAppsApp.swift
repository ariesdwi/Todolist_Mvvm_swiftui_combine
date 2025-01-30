//
//  TodoListAppsApp.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

import SwiftUI
import netfox


@main
struct TodoListAppsApp: App {
    private var addNoteWrapper = AddNoteWrapper()
    
    init() {
#if DEBUG
        NFX.sharedInstance().start()
#endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(addNoteWrapper)
        }
    }
}

