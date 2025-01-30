//
//  ListNoteViewModel.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//


import Foundation
import Combine

struct ErrorMessage: Identifiable {
    let id = UUID()
    let message: String
}

internal final class ListNoteViewModel: ObservableObject {
    
    // MARK: - Properties
    private let coordinator: ListNoteCoordinator
    private let useCase: ListNoteUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var dataList: [NoteModel]? = []
    @Published var successAddData: Bool? = false
    @Published var errorMessage: String? = nil
    
    // MARK: - Initializer
    init(coordinator: ListNoteCoordinator, useCase: ListNoteUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    // MARK: - Functions
    
    func loadNotes() {
        useCase.fetch()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = "Failed to load notes: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] notes in
                self?.dataList = notes
            }
            .store(in: &cancellables)
    }
    
    func addNewNote(id: String, title: String, description: String, priority: NoteModel.Priority) {
        useCase.save(param: .init(id: id, title: title, description: description, todoCount: 0, priority: priority))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = "Failed to add note: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] success in
                self?.successAddData = success
                self?.loadNotes() 
            }
            .store(in: &cancellables)
    }
    
    func toggleNoteCompletion(note: NoteModel) {
        guard let noteIndex = dataList?.firstIndex(of: note) else { return }
        dataList?[noteIndex].completed.toggle()
        
        let updatedNote = dataList?[noteIndex]
        let request = MarkRequestModel(
            id: note.id,
            isCompleted: updatedNote?.completed ?? false
        )
        
        useCase.update(param: .init(
            id: request.id,
            title: updatedNote?.title ?? "",
            completed: request.isCompleted,
            description: updatedNote?.descriptionnote ?? "",
            priority: updatedNote?.priority ?? .low
        ))
        
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.errorMessage = "Failed to update note: \(error.localizedDescription)"
            }
        } receiveValue: { _ in
            debugPrint("Successfully updated note!")
        }
        .store(in: &cancellables)
    }
    
    func deleteNoteById(noteId: String) {
        useCase.delete(id: noteId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = "Failed to delete note: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] _ in
                self?.dataList?.removeAll { $0.id == noteId }
            }
            .store(in: &cancellables)
    }
}
