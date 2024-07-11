//
//  TodoTimer.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/14/24.
//

import SwiftUI

struct TodoTimer: View {
    
    @EnvironmentObject var viewModel: TodoViewModel
    @Binding var isPresented: Bool
    @State private var progress: Double = 0.0
    @State private var isStarted = false
    @State private var isRunning = false
    @State private var timeRemaining: TimeInterval = 1200 // 20분
    @State private var timer: Timer?
    @State var todo: Todo
    @State var memoModalIsPresented = false

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .frame(width: 250, height: 250)
                    .foregroundColor(.gray)
                
                VStack {
                    Text(viewModel.formatTime())
                        .font(.system(size: 70))
                        .foregroundStyle(.opacity(0.5))
                    Text(viewModel.formatMinute())
                        .font(.system(size: 16))
                        .foregroundStyle(.opacity(0.5))
                }
                .padding(40)
                
                if viewModel.getTimePercent(todo: todo.id) < 0 {
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(abs(viewModel.getTimePercent(todo: todo.id)), 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                        .frame(width: 250, height: 250)
                        .foregroundColor(Color(.red))
                        .rotationEffect(Angle(degrees: 270.0))
                } else {
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(viewModel.getTimePercent(todo: todo.id), 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                        .frame(width: 250, height: 250)
                        .foregroundColor(Color(.black))
                        .rotationEffect(Angle(degrees: 270.0))
                }
            }

            if !isStarted {
                Button(action: {
                    isStarted = true
                    isRunning = true
                    viewModel.setTimeData(todo: todo.id)
                    viewModel.startTimer(todo: todo.id)
                }, label: {
                    TextButton(content: "타이머 시작하기")
                        .padding(.vertical, 20)
                })
            } else {
                HStack {
                    Button(action: {
                        if isRunning {
                            // 일시정지
                            viewModel.stopTimer(todo: todo.id)
                            isRunning = false
                        } else {
                            // 타이머 재개
                            viewModel.startTimer(todo: todo.id)
                            isRunning = true
                        }
                    }, label: {
                        SystemImageButton(imageName: isRunning ? SystemImage.pause.name : SystemImage.play.name, width: 12, height: 12)
                    })

                    Button {
                        // 완료
                        isStarted = false
                        isRunning = false
                        viewModel.todoHasDone(todo: todo)
                        // TODO: 완료 메모 화면으로
                        memoModalIsPresented.toggle()
                    } label: {
                        TextButton(content: "할 일 완료")
                    }
                }
                .padding(.vertical, 20)
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
        .sheet(isPresented: $memoModalIsPresented, content: {
            CompletionMemo(todo: todo, memoIsPresented: $memoModalIsPresented)
                .presentationDetents([.height(500)])
                .presentationDragIndicator(.visible)
        })
    }
}

#Preview("TodoTimer") {
    TodoTimer(isPresented: .constant(true), todo: Todo(title: "TodoTimer", requiredTime: 1, createdAt: Date()))
        .environmentObject(TodoViewModel())
}

