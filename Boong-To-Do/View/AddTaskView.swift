//
//  AddTaskView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/11/24.
//

import SwiftUI

/**할일 추가 모달화면*/
struct AddTaskView: View {
    
    @State var taskTitle: String = ""
    @State var taskDesciptions: String = ""
    // 상위 뷰 모달 상태
    @Binding var addTaskModalViewIsPresented: Bool
    // 하위 뷰(시간 선택) 모달 상태
    @State var durationSelectorIsPresented = false
    
    var body: some View {
        VStack {
            // TODO: 화면이 표시되자마자 키보드 활성화 되어있어야 함
            // TODO: 키보드 활성화 상태의 모달 뷰 화면 크기 조정해야함(반만 차지하게)
            TextField("할일 제목 입력", text: $taskTitle, prompt: Text("할 일을 입력해주세요."))
                .frame(width: 335, height: 24)
                .padding(.top, 30)
            
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
                            icon: { Image(systemName: "clock") }
                        )
                        .foregroundStyle(.gray)
                        .frame(width: 140, height: 40)
                        .background(.gray.opacity(0.3))
                        .clipShape(.rect(cornerRadius: 4))
                        Spacer()
                    }
                    .padding(.horizontal)
                })
                // 터치 시, 모달 뷰 Dismiss
                Button(action: {
                    addTaskModalViewIsPresented.toggle()
                }, label: {
                    Image(systemName: "arrow.up")
                        .foregroundStyle(.white)
                        .frame(width: 32, height: 32)
                        .background(.black)
                        .clipShape(Circle())
                        .padding()
                })
            }.sheet(isPresented: $durationSelectorIsPresented, content: {
                // TODO: 키보드에 화면 밀림 현상 해결하기
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
