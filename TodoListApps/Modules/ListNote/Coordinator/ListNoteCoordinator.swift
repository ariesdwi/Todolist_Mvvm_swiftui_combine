//
//  ListNoteCoordinator.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//


import SwiftUI
import Combine

public final class ListNoteCoordinator: ObservableObject {
    
    // MARK: - Properties
    @Published var isAddNotePresented: Bool = false
    
    // MARK: - Initializer
    init() {    }
    
    // MARK: - Routing Methods
    func routeToAddNote() {
        self.isAddNotePresented = true
    }
    
    func closeAddNote() {
        self.isAddNotePresented = false
    }
    
    func routeToDetail(note: NoteModel) -> some View {
        let detailCoordinator = DetailNoteCoordinator()
        return detailCoordinator.routeToDetail(note: note)
    }
    
    // MARK: - View Model Creation
    func makeViewModel() -> ListNoteViewModel {
        let repository = ListLocalNoteRepository()
        let useCase = DefaultNoteListUseCase(repository: repository)
        return ListNoteViewModel(coordinator: self, useCase: useCase)
    }
    
    // MARK: - View Creation
    func create() -> ListNoteView {
        let viewModel = makeViewModel()
        return ListNoteView(viewModel: viewModel, coordinator: self)
    }
}
