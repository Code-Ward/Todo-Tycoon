//
//  TodoListView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/13/24.
//

import SwiftUI

/**할일 추가 완료 시, 할일 목록을 보여주는 화면*/
struct TodoListView: View {
    
    @EnvironmentObject var viewModel: TodoViewModel
    @State var isPresented = false
    @State var addTodoIsPresented = false
    @State var completeModalIsPresented = false
    @State private var selectedTodo: Todo = Todo(title: "", requiredTime: 0, createdAt: Date.now)
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                
                HStack {
                    Text("\(viewModel.notCompleteTodos.count + viewModel.processingTodos.count)개의 할 일")
                    
                    Spacer()
                    
                    // TODO: 정렬 기능 구현하기(추후 개발)
                    Text("정렬")
                    Image(systemName: SystemImage.alignArrow.name)
                }
                .padding()
                
                VStack {
                    
                    // MARK: 진행중 할일 리스트
                    if !viewModel.processingTodos.isEmpty {
                        Section {
                            ForEach(viewModel.processingTodos) { todo in
                                TodoListCell(todo: todo)
                                    .sheet(isPresented: $isPresented, content: {
                                        TodoDetailView(todo: selectedTodo, isPresented: $isPresented)
                                            .presentationDetents([.height(580)])
                                            .presentationDragIndicator(.visible)
                                    })
                                    .onChange(of: isPresented) { _, _ in
                                        viewModel.fetchTodo()
                                    }
                                    .onTapGesture {
                                        selectedTodo = todo
                                        // TodoDetailView 불러오기
                                        isPresented.toggle()
                                    }
                            }
                            .padding(.bottom, 40)
                        } header: {
                            
                            HStack {
                                Text("진행 중")
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    
                    // MARK: 미완료 할일 리스트
                    if !viewModel.notCompleteTodos.isEmpty {
                        Section {
                            ForEach(viewModel.notCompleteTodos) { todo in
                                TodoListCell(todo: todo)
                                    .sheet(isPresented: $isPresented, content: {
                                        TodoDetailView(todo: selectedTodo, isPresented: $isPresented)
                                            .presentationDetents([.height(580)])
                                            .presentationDragIndicator(.visible)
                                    })
                                    .onChange(of: isPresented) { _, _ in
                                        viewModel.fetchTodo()
                                    }
                                    .onTapGesture {
                                        selectedTodo = todo
                                        // TodoDetailView 불러오기
                                        isPresented.toggle()
                                    }
                            }
                            
                        }
                    }
                    
                    // MARK: 완료 할일 리스트
                    if !viewModel.completeTodos.isEmpty {
                        Section {
                            ForEach(viewModel.completeTodos) { todo in
                                TodoListCell(todo: todo)
                                    .sheet(isPresented: $completeModalIsPresented, content: {
                                        VStack {
                                            HStack {
                                                Spacer()
                                                
                                                Button {
                                                    // TODO: 기능 추가 예정(미정)
                                                } label: {
                                                    EllipsisMenu()
                                                }
                                            }
                                            
                                            TodoInfo(todo: selectedTodo)
                                            
                                            HStack {
                                                Text("메모")
                                                    .bold()
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                            }
                                            
                                            if let memo = todo.memo {
                                                ForEach(memo, id: \.self) { item in
                                                    
                                                    Text(item.content)
                                                        .frame(maxWidth: .infinity, maxHeight: 216, alignment: .topLeading)
                                                        .padding()
                                                        .multilineTextAlignment(.leading)
                                                        .background(.textBox)
                                                        .clipShape(.rect(cornerRadius: 12))
                                                }
                                            }
                                        }
                                        .padding()
                                        .presentationDetents([.height(480)])
                                        .presentationDragIndicator(.visible)
                                        .onDisappear(perform: {
                                            viewModel.fetchTodo()
                                        })
                                        .onAppear {
                                            print(todo.memo?.count ?? "No Memo")
                                        }
                                    })
                            }
                            .onTapGesture {
                                viewModel.fetchTodo()
                                completeModalIsPresented.toggle()
                            }
                        } header: {
                            HStack {
                                Text("완료")
                                
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    
                    Spacer()
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    // MARK: 할일 추가
                    Button(action: {
                        addTodoIsPresented.toggle()
                    }, label: {
                        ZStack {
                            Image(systemName: SystemImage.plus.name)
                                .resizable()
                                .frame(width: 23, height: 23)
                                .foregroundStyle(.white)
                                .frame(width: 48, height: 48)
                                .background(.black)
                                .clipShape(Circle())
                        }
                        .padding()
                    })
                    .sheet(isPresented: $addTodoIsPresented, content: {
                        // 할일 추가 화면 모달뷰
                        AddTodoView(addTodoModalViewIsPresented: $addTodoIsPresented)
                            .presentationDetents([.height(200)])
                            .presentationDragIndicator(.visible)
                    })
                }
            }
            
        }
    }
}

#Preview("TodoList") {
    TodoListView()
        .environmentObject(TodoViewModel())
}

struct TodoListCell: View {
    
    @EnvironmentObject var viewModel: TodoViewModel
    var todo: Todo
    
    var body: some View {
        HStack {
            Button {
                if todo.finishedAt == nil {
                    // 할일 완료 기능
                    viewModel.todoHasDone(todo: todo)
                    viewModel.fetchTodo()
                }
            } label: {
                if todo.finishedAt != nil {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundStyle(todo.finishedAt != nil ? .secondaryText.opacity(0.5) : .primaryText)
                } else {
                    Image(systemName: "square")
                }
            }
            
            
            Text(todo.title)
                .font(.system(size: 14))
                .foregroundStyle(todo.finishedAt != nil ? .secondaryText : .primaryText)
                .padding(.horizontal, 10)
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Label("\((todo.requiredTime - todo.executedTime) / 60)분", systemImage: SystemImage.clock.name)
                    .font(.system(size: 10))
                    .foregroundStyle(.black)
            })
            .frame(width: 50, height: 18)
            .background(.gray).opacity(0.3)
            .clipShape(.rect(cornerRadius: 4))
            
        }
        .padding(20)
        .background(todo.finishedAt != nil ? .secondaryText.opacity(0.1) : .white)
        .clipShape(.rect(cornerRadius: 12))
        .contextMenu {
            Button(role: .destructive) {
                viewModel.deleteTodo(id: todo.id)
            } label: {
                Label("삭제하기", systemImage: "trash")
            }
        }
        .clipShape(.rect(cornerRadius: 12))
        .padding(.horizontal, 10)
    }
}

#Preview("TodoListCell") {
    TodoListCell(todo: Todo(title: "프리뷰", requiredTime: 15, createdAt: Date.now))
}
