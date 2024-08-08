//
//  TodoProcessView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/25/24.
//

import SwiftUI

/**할일 시작 시, 보여지는 타이머 화면(모달)
 
 할일 상세목록 + 타이머
 */
struct TodoDetailView: View {
    
    @EnvironmentObject var viewModel: TodoViewModel
    @State var todo: Todo
    @State var alertPresented: Bool = false
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                if !viewModel.isEditing {
                    Menu {
                        // 삭제하기
                        Button(role: .destructive) {
                            print("삭제하기")
                            alertPresented.toggle()
                        } label: {
                            Label("삭제하기", systemImage: SystemImage.trash.name)
                        }
                        // 수정하기
                        Button() {
                            // Action -
                            print("수정하기")
                            viewModel.isEditing.toggle()
                        } label: {
                            Label("수정하기", systemImage: "pencil.tip.crop.circle")
                        }
                    } label: {
                        Image(systemName: SystemImage.ellipsis.name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.black)
                    }
                    .alert(isPresented: $alertPresented) {
                        let deleteButton = Alert.Button.default(Text("삭제하기")) {
                            // 삭제하기 동작 코드
                            print("삭제하기 동작")
                            alertPresented.toggle()
                            viewModel.deleteTodo(id: todo.id)
                        }
                        let cancelButton = Alert.Button.cancel(Text("취소")) {
                            // 취소 동작 코드
                            print("취소 동작")
                            alertPresented.toggle()
                        }
                        return Alert(title: Text("할 일 삭제"), message: Text("할일을 정말 삭제하시겠습니까?"), primaryButton: cancelButton, secondaryButton: deleteButton)
                    }
                } else {
                    Button {
                        viewModel.isEditing.toggle()
                        
                    } label: {
                        Text("완료")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .bold()
                            .frame(width: 50, height: 30)
                            .background(.black)
                            .clipShape(.rect(cornerRadius: 8))
                            .padding()
                    }

                }
            }
            
            TodoInfo(todo: todo)
            
            TodoTimer(isPresented: $isPresented, todo: todo)
                .onAppear {
                    viewModel.setTimeData(todo: todo.id)
                }
            
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    TodoDetailView(todo: Todo(title: "디테일뷰", requiredTime: 12, createdAt: Date.now), isPresented: .constant(true))
        .environmentObject(TodoViewModel())
}
