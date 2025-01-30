//
//  DetailNoteViewModel.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 08/01/25.
//

import Combine
import Foundation

final class DetailNoteViewModel: ObservableObject {
    @Published var note: NoteModel
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let useCase: DetailNoteUseCase
    private var cancellables = Set<AnyCancellable>()

    // Initializer
    init(noteId: String, useCase: DetailNoteUseCase) {
        self.useCase = useCase
        self.note = NoteModel(id: noteId, title: "", descriptionnote:  "", todoCount: 0, completed: false, priority: .low)
        
        fetchNoteDetails(noteId: noteId)
    }

    // MARK: - Fetch Note Details
    func fetchNoteDetails(noteId: String) {
        isLoading = true
        useCase.fetchNoteById(id: noteId)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.handleError(error) 
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] note in
                if let note = note {
                    self?.note = note
                } else {
                    self?.errorMessage = "Note not found"
                }
            })
            .store(in: &cancellables)
    }

    // MARK: - Update Note Details (Title, Description, Priority)
    func updateNote(newTitle: String, newDescription: String, newPriority: NoteModel.Priority, onSuccess: @escaping () -> Void) {
        let param = UpdateNoteRequestDTO(id: note.id, title: newTitle, completed: note.completed, description: newDescription, priority: newPriority.rawValue)

        isLoading = true
        useCase.updateNoteDetails(param: param)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.handleError(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] _ in
                debugPrint("Successfully updated note!")
                self?.note.title = newTitle
                self?.note.descriptionnote = newDescription
                self?.note.priority = newPriority
               
                onSuccess()
            })
            .store(in: &cancellables)
    }

    // MARK: - Delete Note
    func deleteNote() {
        isLoading = true
        useCase.deleteNoteById(id: note.id)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.handleError(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] _ in
                self?.note = NoteModel(id: "", title: "", descriptionnote: "0", todoCount: 0, completed: false, priority: .low)
            })
            .store(in: &cancellables)
    }

    // MARK: - Error Handling
    private func handleError(_ error: Error) {
        if let networkError = error as? NetworkError {
            self.errorMessage = "Network error: \(networkError.localizedDescription)"
        } else {
            self.errorMessage = "An error occurred: \(error.localizedDescription)"
        }
    }
}

