//
//  EmptyListView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/11/24.
//

import SwiftUI

/**할일이 없을 때, 표시되는 뷰*/
struct EmptyListView: View {
    
    // 할일 추가하는 모달 뷰
    @State var addTaskIsPresented = false
    
    var body: some View {
        ZStack {
            // 배경색
            Color.secondary.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                Spacer(minLength: 80)
                // TODO: 로고 미정
                Text("이미지")
                    .frame(width: 150, height: 146)
                    .background(.white)
                    .padding(.bottom, 30)
                VStack {
                    Text("할일이 아직 없어요")
                    // 터치 시, 할일 추가 모달 나타남
                    Button(action: {
                        addTaskIsPresented.toggle()
                    }, label: {
                        Text("추가하러 가기")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .bold()
                            .frame(width: 113, height: 34)
                            .background(.black)
                            .clipShape(.rect(cornerRadius: 8))
                    })
                    Spacer()
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    // 터치 시, 할일 추가 모달 나타남
                    Button(action: {
                        addTaskIsPresented.toggle()
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
                    .sheet(isPresented: $addTaskIsPresented, content: {
                        // 할일 추가 화면 모달뷰
                        AddTaskView(addTodoModalViewIsPresented: $addTaskIsPresented)
                            .presentationDetents([.height(200)])
                            .presentationDragIndicator(.visible)
                    })
                }
            }
        }
    }
}

#Preview {
    EmptyListView()
}
