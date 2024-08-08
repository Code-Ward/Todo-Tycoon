//
//  TodoDetail.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/25/24.
//

import SwiftUI

/**할일 상세사항을 보여주는 뷰*/
struct TodoInfo: View {
    
    @EnvironmentObject var viewModel: TodoViewModel
    @State var todo: Todo
    @State var isRequiredTimeEditing = false
    @State var durationSelectorPresented = false
    @State var titleEdit = ""
    @State var contentEdit = ""
    @State var requiredTime = 0
    
    var body: some View {
        VStack {
            // MARK: 제목
            HStack {
                if viewModel.isEditing {
                    TextField(todo.title, text: $titleEdit)
                        .font(.system(size: 16))
                        .bold()
                        .onChange(of: titleEdit) {
                            todo.title = titleEdit
                        }
                        
                } else {
                    Text("\(todo.title)")
                        .font(.system(size: 16))
                        .bold()
                    Spacer()
                }
                    
            }
            .frame(maxWidth: .infinity)
            .frame(height: 24)
            .onChange(of: viewModel.isEditing) {
                if titleEdit.isEmpty {
                    print("No Changes")
                } else {
                    viewModel.changeTodoTitle(todo: todo, title: titleEdit)
                    viewModel.fetchTodo()
                    print("Edit Complete")
                }
            }
            
            // MARK: 설명
            HStack {
                if viewModel.isEditing {
                    TextField(todo.content, text: $contentEdit)
                        .font(.system(size: 12))
                        .bold()
                        .frame(minHeight: 50, alignment: .top)
                        .onChange(of: contentEdit) {
                            todo.content = contentEdit
                        }
                        
                } else {
                    if todo.content.isEmpty {
                        Text("설명 없음")
                            .font(.system(size: 12))
                            .frame(minHeight: 50, alignment: .top)
                            .lineLimit(8)
                    } else {
                        Text("\(todo.content)")
                            .font(.system(size: 12))
                            .frame(minHeight: 50, alignment: .top)
                            .lineLimit(8)
                    }
                    
                    Spacer()
                }
            }
            .sheet(isPresented: $durationSelectorPresented, content: {
                DurationSelector(isPresented: $durationSelectorPresented, todoRequiredTime: $requiredTime)
                    .presentationDetents([.height(368)])
                    .presentationDragIndicator(.visible)
            })
            .onChange(of: viewModel.isEditing) {
                if contentEdit.isEmpty {
                    print("No Changes")
                } else {
                    viewModel.changeTodoContent(todo: todo, content: contentEdit)
                    print("Edit Complete")
                }
            }
            
            // MARK: 예상소요시간
            HStack {
                Label(
                    title: {
                        Text("예상 소요 시간 \(todo.requiredTime/60)분")
                            .font(.system(size: 12))
                            .onChange(of: requiredTime) {
                                todo.requiredTime = requiredTime
                            }
                    },
                    icon: {
                        Image(systemName: SystemImage.clock.name)
                            .frame(width: 18, height: 18)
                    }
                )
                .foregroundStyle(.gray)
                .frame(width: 140, height: 30)
                .background(.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 4))
                .padding(.bottom, 10)
                .onTapGesture {
                    isRequiredTimeEditing.toggle()
                    durationSelectorPresented.toggle()
                }
                
                Spacer()
                
                if isRequiredTimeEditing {
                    Button(action: {
                        isRequiredTimeEditing.toggle()
                        viewModel.changeTodoRequiredTime(todo: todo, requiredTime: requiredTime)
                        viewModel.setTimeData(todo: todo.id)
                        viewModel.fetchTodo()
                    }, label: {
                        Text("완료")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .bold()
                            .frame(width: 50, height: 30)
                            .background(.black)
                            .clipShape(.rect(cornerRadius: 8))
                    })
                }
                
            }
        }
    }
}

#Preview("TodoDetail") {
    TodoInfo(todo: Todo(title: "TodoDetail", requiredTime: 1, createdAt: Date.now))
        .environmentObject(TodoViewModel())
}


