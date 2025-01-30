//
//  ContentView.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

import SwiftUI
import Combine

class AddNoteWrapper: ObservableObject {
    @Published var isPresented: Bool = false
    let notePublisher = PassthroughSubject<NoteModel, Never>()
}

struct ContentView: View {
    @StateObject private var coordinator = ListNoteCoordinator()

    var body: some View {
            coordinator.create()
                .edgesIgnoringSafeArea(.top)
                .sheet(isPresented: $coordinator.isAddNotePresented) {
                    AddNoteView(coordinator: coordinator)
                }
    }
}

