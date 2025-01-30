//
//  DetailNoteCoordinator.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 08/01/25.
//

import SwiftUI

final class DetailNoteCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()

    // MARK: - Public API

    func navigateBack() {
        navigationPath.removeLast()
    }

    func routeToDetail(note: NoteModel) -> DetailNoteView {
        let repository = makeDetailNoteRepository()
        let useCase = makeDetailNoteUseCase(repository: repository)
        let viewModel = makeDetailNoteViewModel(note: note, useCase: useCase)
        
        return DetailNoteView(viewModel: viewModel, coordinator: self)
    }

    // MARK: - Dependency Creation

    private func makeDetailNoteRepository() -> DetailNoteRepository {
        return LocalDetailNoteRepository()
    }

    private func makeDetailNoteUseCase(repository: DetailNoteRepository) -> DefaultDetailNoteUseCase {
        return DefaultDetailNoteUseCase(repository: repository)
    }

    private func makeDetailNoteViewModel(note: NoteModel, useCase: DefaultDetailNoteUseCase) -> DetailNoteViewModel {
        return DetailNoteViewModel(
            noteId: note.id, useCase: useCase
        )
    }
}

