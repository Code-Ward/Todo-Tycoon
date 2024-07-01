//
//  AddTaskView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/11/24.
//

import SwiftUI

/**할일 추가 모달화면*/
struct AddTaskView: View {
    
    @EnvironmentObject var viewModel: TaskViewModel
    @State var taskTitle: String = ""
    @State var taskDesciptions: String = ""
    @State var taskRequiredTime: Int = 0
    // 상위 뷰 모달 상태
    @Binding var addTaskModalViewIsPresented: Bool
    // 하위 뷰(시간 선택) 모달 상태
    @State var durationSelectorIsPresented = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            TextField("할일 제목 입력", text: $taskTitle, prompt: Text("할 일을 입력해주세요."))
                .frame(width: 335, height: 24)
                .padding(.top, 30)
                .focused($isFocused)
                .onAppear {
                    isFocused = true
                }
            
            TextField("설명 입력", text: $taskDesciptions, prompt: Text("설명"))
                .frame(width: 335, height: 24)
                .padding(.bottom, 40)
            
            HStack {
                // 터치 시, 시간 선택 창으로
                Button(action: {
                    durationSelectorIsPresented.toggle()
                }, label: {
                    HStack {
                        Label(
                            title: { Text("예상 소요 시간") },
                            icon: { Image(systemName: SystemImage.clock.name) }
                        )
                        .foregroundStyle(.gray)
                        .frame(width: 140, height: 40)
                        .background(.gray.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 4))
                        Spacer()
                    }
                    .padding(.horizontal)
                })
                // MARK: 터치 시, 데이터 저장 후 뷰 Dismiss
                Button(action: {
                    viewModel.getSaveTask(title: taskTitle, content: taskDesciptions, time: taskRequiredTime)
                    addTaskModalViewIsPresented.toggle()
                }, label: {
                    Image(systemName: SystemImage.upArrow.name)
                        .foregroundStyle(.white)
                        .frame(width: 32, height: 32)
                        .background(.black)
                        .clipShape(Circle())
                        .padding()
                })
            }.sheet(isPresented: $durationSelectorIsPresented, content: {
                DurationSelector(isPresented: $durationSelectorIsPresented)
                    .presentationDetents([.height(368)])
                    .presentationDragIndicator(.visible)
            })
            Spacer()
        }
    }
}

#Preview {
    AddTaskView(taskTitle: "", taskDesciptions: "", addTaskModalViewIsPresented: .constant(false))
}
