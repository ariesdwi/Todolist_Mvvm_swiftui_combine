
//  DetailNoteView.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 08/01/25.
//

import SwiftUI

struct DetailNoteView: View {
    @StateObject var viewModel: DetailNoteViewModel
    @ObservedObject var coordinator: DetailNoteCoordinator

    @Environment(\.presentationMode) var presentationMode

    init(viewModel: DetailNoteViewModel, coordinator: DetailNoteCoordinator) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _coordinator = ObservedObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding(.vertical)
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Title")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            TextField("Enter Note Title", text: Binding(
                                get: { viewModel.note.title ?? "" },
                                set: { newValue in
                                    viewModel.note.title = newValue
                                }
                            ))
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            TextField("Enter Note Description", text: Binding(
                                get: { viewModel.note.descriptionnote ?? "" },
                                set: { newValue in
                                    viewModel.note.descriptionnote = newValue
                                }
                            ))
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Priority")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Picker("Select Priority", selection: $viewModel.note.priority) {
                                Text("Low").tag(NoteModel.Priority.low)
                                Text("Medium").tag(NoteModel.Priority.medium)
                                Text("High").tag(NoteModel.Priority.high)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding(.horizontal)

                        HStack {
                            Text("Status:")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(viewModel.note.completed ? "Completed" : "Not Completed")
                                .fontWeight(.bold)
                                .padding(8)
                                .background(viewModel.note.completed ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)

                        Button(action: {
                            viewModel.updateNote(
                                newTitle: viewModel.note.title ?? "",
                                newDescription: viewModel.note.descriptionnote ?? "",
                                newPriority: viewModel.note.priority
                            ) {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text("Save Changes")
                                .fontWeight(.semibold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.isLoading || (viewModel.note.title?.isEmpty ?? true) ? Color.gray : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.2), radius: 5)
                        }
                        .disabled(viewModel.isLoading || (viewModel.note.title?.isEmpty ?? true))
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .onAppear {
                if viewModel.note.id.isEmpty {
                    viewModel.fetchNoteDetails(noteId: viewModel.note.id)
                }
            }
            
        }
    }
}





