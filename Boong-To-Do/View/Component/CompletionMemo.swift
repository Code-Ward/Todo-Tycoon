//
//  CompletionMemo.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/25/24.
//

import SwiftUI

/**할일 완료시 메모를 작성하는 화면*/
struct CompletionMemo: View {
    
    @EnvironmentObject var viewModel: TodoViewModel
    @State var todo: Todo
    @State var inputMemo = ""
    @Binding var memoIsPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    // 모달 뷰 해제
                    memoIsPresented = false
                } label: {
                    Image(systemName: "arrow.backward")
                }
                Spacer()
                
                Text("완료")
                    .bold()
                
                Spacer()

                Button {
                    // 메모 저장 + 홈화면 이동
                    viewModel.saveMemo(todo: todo.id, memo: inputMemo)
                    memoIsPresented = false
                    viewModel.fetchTodo()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            .padding(.bottom, 15)
            
            TodoInfo(todo: todo)
            
            Text("메모")
                .foregroundStyle(.secondary)
            
            TextField(text: $inputMemo) {
                Text("완료한 메모 작성해주세요")
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 216, alignment: .top)
            .background(.textBox)
            .clipShape(.rect(cornerRadius: 12))
        }
        .padding()
    }
}

#Preview {
    CompletionMemo(todo: Todo(title: "CompletionMemo", requiredTime: 12, createdAt: Date()), memoIsPresented: .constant(true))
        .environmentObject(TodoViewModel())
}
