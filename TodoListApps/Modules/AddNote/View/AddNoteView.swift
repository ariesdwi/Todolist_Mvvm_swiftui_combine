//  AddNoteViewController.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 07/01/25.
//


import SwiftUI

struct AddNoteView: View {
    @EnvironmentObject private var addNoteWrapper: AddNoteWrapper
    @State private var noteText: String = ""
    @State private var noteDescription: String = ""
    @State private var notePriority: NoteModel.Priority = .low

    var coordinator: ListNoteCoordinator

    var body: some View {
        VStack(spacing: 20) {
            Text("Add a New Note")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 10)

            TextField("Enter your note title...", text: $noteText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color(.systemGray6))
                .cornerRadius(8)

            TextField("Enter note description...", text: $noteDescription)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color(.systemGray6))
                .cornerRadius(8)

            Picker("Priority", selection: $notePriority) {
                Text("Low").tag(NoteModel.Priority.low)
                Text("Medium").tag(NoteModel.Priority.medium)
                Text("High").tag(NoteModel.Priority.high)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.top, 10)

            HStack {
                Button(action: {
                    coordinator.isAddNotePresented = false
                    
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                }

                Button(action: {
                    if !noteText.isEmpty && !noteDescription.isEmpty {
                        let newNote = NoteModel(
                            id: UUID().uuidString,
                            title: noteText,
                            descriptionnote: noteDescription,
                            todoCount: 0,
                            completed: false,
                            priority: notePriority
                        )
                        
                        addNoteWrapper.notePublisher.send(newNote)
                        coordinator.isAddNotePresented = false
                    }
                }) {
                    Text("Add Note")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(noteText.isEmpty || noteDescription.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                }
                .disabled(noteText.isEmpty || noteDescription.isEmpty)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 10)
        .padding()
        .onAppear {
            noteText = ""
            noteDescription = ""  
        }
    }
}
