//
//  ListNoteViewController.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

//import SwiftUI
//import Combine
//
//
//struct ListNoteView: View {
//    @StateObject private var viewModel: ListNoteViewModel
//    @ObservedObject private var coordinator: ListNoteCoordinator
//    @EnvironmentObject private var addNoteWrapper: AddNoteWrapper
//
//    @State private var searchText = ""
//    @State private var selectedPriority: NoteModel.Priority = .all
//
//    init(viewModel: ListNoteViewModel, coordinator: ListNoteCoordinator) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//        _coordinator = ObservedObject(wrappedValue: coordinator)
//    }
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Picker("Filter by Priority", selection: $selectedPriority) {
//                    Text("All").tag(NoteModel.Priority.all)
//                    Text("Low").tag(NoteModel.Priority.low)
//                    Text("Medium").tag(NoteModel.Priority.medium)
//                    Text("High").tag(NoteModel.Priority.high)
//                }
////                .pickerStyle(SegmentedPickerStyle())
//                .pickerStyle(MenuPickerStyle())
//                .padding()
//                
//                if let notes = viewModel.dataList, !notes.isEmpty {
//                    List {
//                        ForEach(filteredNotes, id: \.id) { note in
//                            NavigationLink(
//                                destination: coordinator.routeToDetail(note: note)
//                            ) {
//                                ListNoteRow(
//                                    text: note.title ?? "",
//                                    description: note.descriptionnote ?? "No description provided.",
//                                    priority: note.priority,
//                                    isCompleted: Binding(
//                                        get: { note.completed },
//                                        set: { newValue in
//                                            viewModel.toggleNoteCompletion(note: note)
//                                        }
//                                    ),
//                                    onMarkComplete: { viewModel.toggleNoteCompletion(note: note) },
//                                    onDelete: { viewModel.deleteNoteById(noteId: note.id) }
//                                )
//                            }
//                        }
//                        .onDelete(perform: { indexSet in
//                            guard let index = indexSet.first else { return }
//                            let noteId = notes[index].id
//                            viewModel.deleteNoteById(noteId: noteId)
//                        })
//                    }
//                    .listStyle(PlainListStyle())
//                    .background(Color.clear)
//                    .scrollContentBackground(.hidden)
//                    .listRowSeparator(.hidden)
//                    .scrollIndicators(.hidden)
//                    .searchable(text: $searchText)
//                    .padding([.leading, .trailing, .top], 16)
//                } else {
//                    Spacer()
//                    VStack {
//                        Image(systemName: "note.text")
//                            .font(.system(size: 50))
//                            .foregroundColor(.gray)
//                            .padding(.bottom, 8)
//                        Text("No notes available")
//                            .foregroundColor(.gray)
//                            .font(.headline)
//                    }
//                    Spacer()
//                }
//                
//                // Add New Reminder Button
//                Button(action: {
//                    coordinator.routeToAddNote()
//                }) {
//                    Text("Add New Reminder")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                        .shadow(radius: 5)
//                        .padding([.leading, .trailing], 16)
//                }
//                .padding([.bottom, .top], 24)
//            }
//            .navigationTitle("Notes")
//            .navigationBarTitleDisplayMode(.automatic)
//            .onAppear {
//                viewModel.loadNotes()
//            }
//            .onReceive(addNoteWrapper.notePublisher) { newNote in
//                viewModel.addNewNote(id: newNote.id, title: newNote.title ?? "", description: newNote.descriptionnote ?? "", priority: newNote.priority)
//            }
//        }
//    }
//
//    var filteredNotes: [NoteModel] {
//        var filtered = viewModel.dataList ?? []
//
//        if !searchText.isEmpty {
//            filtered = filtered.filter { note in
//                let titleMatches = note.title?.lowercased().contains(searchText.lowercased()) ?? false
//                let descriptionMatches = note.descriptionnote?.lowercased().contains(searchText.lowercased()) ?? false
//                return titleMatches || descriptionMatches
//            }
//        }
//
//       
//        if selectedPriority != .all {
//            filtered = filtered.filter { note in
//                note.priority == selectedPriority
//            }
//        }
//
//        return filtered
//    }
//}

import SwiftUI
import Combine

struct ListNoteView: View {
    @StateObject private var viewModel: ListNoteViewModel
    @ObservedObject private var coordinator: ListNoteCoordinator
    @EnvironmentObject private var addNoteWrapper: AddNoteWrapper

    @State private var searchText = ""
    @State private var selectedPriority: NoteModel.Priority = .all

    init(viewModel: ListNoteViewModel, coordinator: ListNoteCoordinator) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _coordinator = ObservedObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationView {
            VStack {
                if let notes = viewModel.dataList, !notes.isEmpty {
                    List {
                        ForEach(filteredNotes, id: \.id) { note in
                            NavigationLink(
                                destination: coordinator.routeToDetail(note: note)
                            ) {
                                ListNoteRow(
                                    text: note.title ?? "",
                                    description: note.descriptionnote ?? "No description provided.",
                                    priority: note.priority,
                                    isCompleted: Binding(
                                        get: { note.completed },
                                        set: { newValue in
                                            viewModel.toggleNoteCompletion(note: note)
                                        }
                                    ),
                                    onMarkComplete: { viewModel.toggleNoteCompletion(note: note) },
                                    onDelete: { viewModel.deleteNoteById(noteId: note.id) }
                                )
                            }
                        }
                        .onDelete(perform: { indexSet in
                            guard let index = indexSet.first else { return }
                            let noteId = notes[index].id
                            viewModel.deleteNoteById(noteId: noteId)
                        })
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                    .listRowSeparator(.hidden)
                    .scrollIndicators(.hidden)
                    .searchable(text: $searchText)
                    .padding([.leading, .trailing, .top], 16)
                } else {
                    Spacer()
                    VStack {
                        Image(systemName: "note.text")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        Text("No notes available")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    Spacer()
                }
                
                // Add New Reminder Button
                Button(action: {
                    coordinator.routeToAddNote()
                }) {
                    Text("Add New Reminder")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding([.leading, .trailing], 16)
                }
                .padding([.bottom, .top], 24)
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker("Priority", selection: $selectedPriority) {
                        Text("All").tag(NoteModel.Priority.all)
                        Text("Low").tag(NoteModel.Priority.low)
                        Text("Medium").tag(NoteModel.Priority.medium)
                        Text("High").tag(NoteModel.Priority.high)
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            .onAppear {
                viewModel.loadNotes()
            }
            .onReceive(addNoteWrapper.notePublisher) { newNote in
                viewModel.addNewNote(
                    id: newNote.id,
                    title: newNote.title ?? "",
                    description: newNote.descriptionnote ?? "",
                    priority: newNote.priority
                )
            }
        }
    }

    var filteredNotes: [NoteModel] {
        var filtered = viewModel.dataList ?? []

        if !searchText.isEmpty {
            filtered = filtered.filter { note in
                let titleMatches = note.title?.lowercased().contains(searchText.lowercased()) ?? false
                let descriptionMatches = note.descriptionnote?.lowercased().contains(searchText.lowercased()) ?? false
                return titleMatches || descriptionMatches
            }
        }

        if selectedPriority != .all {
            filtered = filtered.filter { note in
                note.priority == selectedPriority
            }
        }

        return filtered
    }
}
