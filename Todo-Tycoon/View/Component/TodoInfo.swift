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
    @State var isTitleEditing = false
    @State var isContentEditing = false
    @State var isRequiredTimeEditing = false
    @State var durationSelectorPresented = false
    @State var titleEdit = ""
    @State var contentEdit = ""
    @State var requiredTime = 0
    
    var body: some View {
        VStack {
            // 1번
            HStack {
                if isTitleEditing {
                    TextField(todo.title, text: $titleEdit)
                        .font(.system(size: 16))
                        .bold()
                        .onChange(of: titleEdit) {
                            todo.title = titleEdit
                        }
                    Button(action: {
                        isTitleEditing.toggle()
                        viewModel.changeTodoTitle(todo: todo, title: titleEdit)
                        viewModel.fetchTodo()
                    }, label: {
                        Text("Done")
                    })
                } else {
                    Text("\(todo.title)")
                        .font(.system(size: 16))
                        .bold()
                        .onTapGesture {
                            isTitleEditing.toggle()
                        }
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 24)
            
            // 2번
            HStack {
                if isContentEditing {
                    TextField(todo.content, text: $contentEdit)
                        .font(.system(size: 16))
                        .bold()
                        .onChange(of: contentEdit) {
                            todo.content = contentEdit
                        }
                    Button(action: {
                        isContentEditing.toggle()
                        viewModel.changeTodoContent(todo: todo, content: contentEdit)
                    }, label: {
                        Text("Done")
                    })
                } else {
                    Text("\(todo.content)")
                        .font(.system(size: 12))
                        .frame(minHeight: 50, alignment: .top)
                        .lineLimit(8)
                        .onTapGesture {
                            isContentEditing.toggle()
                        }
                    
                    Spacer()
                }
            }
            .sheet(isPresented: $durationSelectorPresented, content: {
                DurationSelector(isPresented: $durationSelectorPresented, todoRequiredTime: $requiredTime)
                    .presentationDetents([.height(368)])
                    .presentationDragIndicator(.visible)
            })
            
            // 3-1번
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
                    }, label: {
                        Text("Done")
                    })
                }
                
            }
        }
    }
}

#Preview("TodoDetail") {
    TodoInfo(todo: Todo(title: "TodoDetail", requiredTime: 1, createdAt: Date.now))
}


