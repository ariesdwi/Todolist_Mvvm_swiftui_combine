//
//  ListNoteViewModelTests.swift
//  TodoListAppsTests
//
//  Created by Aries Prasetyo on 08/01/25.
//


import XCTest
import Combine
@testable import TodoListApps

final class ListNoteViewModelTests: XCTestCase {

    private var viewModel: ListNoteViewModel!
    private var mockUseCase: MockListNoteUseCase!
    private var cancellables: Set<AnyCancellable>!
    
    // NoteModel Test Data
    private let mockNote = NoteModel(id: "1", title: "Test Note", todoCount: 3, completed: false, priority: .low)
    private let anotherMockNote = NoteModel(id: "2", title: "Another Test Note", todoCount: 5, completed: true, priority: .low)

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockUseCase = MockListNoteUseCase()
        let mockCoordinator = ListNoteCoordinator()
        viewModel = ListNoteViewModel(coordinator: mockCoordinator, useCase: mockUseCase)
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockUseCase = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    // MARK: - ViewModel Tests
    
    func testLoadNotesSuccess() throws {
        let expectedNotes = [mockNote, anotherMockNote]
        mockUseCase.fetchResult = .success(expectedNotes)

        let expectation = XCTestExpectation(description: "Successfully fetch notes")
        viewModel.$dataList
            .dropFirst()
            .sink { notes in
                XCTAssertEqual(notes, expectedNotes, "The notes should match the mock data")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadNotes()

        wait(for: [expectation], timeout: 1.0)
    }

    func testAddNewNoteSuccess() throws {
        mockUseCase.saveResult = .success(true)

    
        let expectation = XCTestExpectation(description: "Successfully add a new note")
        viewModel.$successAddData
            .dropFirst()
            .sink { success in
                XCTAssertTrue(success ?? false, "The success flag should be true")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.addNewNote(id: "2", title: "bocah", description: "What ever it is", priority: .low)

        wait(for: [expectation], timeout: 1.0)
    }

   
    
    func testNoteModelEquality() throws {
        let note1 = NoteModel(id: "1", title: "Test Note", todoCount: 0, completed: true, priority: .low)
        let note2 = NoteModel(id: "1", title: "Test Note", todoCount: 0, completed: true, priority: .low)
        let note3 = NoteModel(id: "2", title: "Another Note", todoCount: 1, completed: false, priority: .low)
        
        XCTAssertTrue(note1 == note2, "Notes with the same id, title, and completion status should be equal.")
        XCTAssertFalse(note1 == note3, "Notes with different ids should not be equal.")
    }
    
    func testNoteModelInitializer() throws {
        let note = NoteModel(id: "1", title: "Test Note", todoCount: 5, completed: false, priority: .low)
    
        XCTAssertEqual(note.id, "1")
        XCTAssertEqual(note.title, "Test Note")
        XCTAssertEqual(note.todoCount, 5)
        XCTAssertFalse(note.completed, "The completed flag should be false.")
    }

}


