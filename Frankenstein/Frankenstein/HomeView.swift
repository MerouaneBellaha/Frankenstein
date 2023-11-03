//
//  HomeView.swift
//  Frankenstein
//
//  Created by Merouane Bellaha on 06/10/2023.
//

import SwiftUI

struct  A {}
struct HomeView: View {
    @FocusState private var isFocused: Bool
    @State var viewModel: HomeViewModel

    init() {
        viewModel = .init()
    }

    var body: some View {
        let _ = Self._printChanges()
        Group {
            List {
                ForEach(viewModel.tasks) { task in
                    Text(task.name)
                        .accessibilityIdentifier(task.name)
                }
                .onDelete(perform: viewModel.deleteTask(atIndex:))
            }
            .scrollContentBackground(.hidden)
            .padding(16)
        }
        .background(.blue.opacity(0.1))

        .safeAreaInset(edge: .bottom) {
            HStack {
                TextField("task name", text: $viewModel.futureTaskName)
                    .padding(7)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .focused($isFocused)
                    .submitLabel(.continue)
                    .onSubmit {
                        viewModel.addTask(named: viewModel.futureTaskName)
                    }
                    .accessibilityIdentifier("task name textField")

                Button("add task") {
                    viewModel.addTask(named: viewModel.futureTaskName)
                    isFocused = false
                }
                .buttonStyle(.bordered)
                .accessibilityIdentifier("add task button")
            }
            .padding(16)
            .background(.blue.opacity(0.2))
        }
    }
}

#Preview {
    HomeView()
}

// MARK: - Model

struct Task: Identifiable {
    let name: String
    let id: UUID

    init(name: String, id: UUID = UUID()) {
        self.name = name
        self.id = id
    }
}

// MARK: - ViewModel

import Observation

@Observable
final class HomeViewModel {
    private(set) var tasks: [Task] = [Task(name: "this is an example")]
    var futureTaskName: String = ""

    func addTask(named: String) {
        tasks.append(Task(name: named))
        cleanFutureTaskName()
    }

    func deleteTask(atIndex index: IndexSet) {
        tasks.remove(atOffsets: index)
    }

    private func cleanFutureTaskName() {
        futureTaskName = ""
    }
}
