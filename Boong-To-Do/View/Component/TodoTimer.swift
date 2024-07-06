//
//  TodoTimer.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/14/24.
//

import SwiftUI

struct TaskTimer: View {
    @State private var progress: Double = 0.0
    @State private var isStarted = false
    @State private var isRunning = false
    @State private var timeRemaining: TimeInterval = 1200 // 20분
    @State private var timer: Timer?

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .frame(width: 250, height: 250)
                    .foregroundColor(.gray)
                
                VStack {
                    Text(timeString(from: timeRemaining))
                        .font(.system(size: 70))
                        .foregroundStyle(.opacity(0.5))
                    Text("20분")
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
                    startTimer()
                }, label: {
                    TextButton(content: "타이머 시작하기")
                        .padding(.vertical, 20)
                })
            } else {
                HStack {
                    Button(action: {
                        if isRunning {
                            pauseTimer()
                        } else {
                            resumeTimer()
                        }
                    }, label: {
                        SystemImageButton(imageName: isRunning ? SystemImage.pause.name : SystemImage.play.name, width: 12, height: 12)
                    })

                    Button {
                        completeTask()
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
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                self.progress = 1 - (self.timeRemaining / 1200)
            } else {
                self.timer?.invalidate()
                self.isRunning = false
            }
        }
        isRunning = true
    }

    func pauseTimer() {
        timer?.invalidate()
        isRunning = false
    }

    func resumeTimer() {
        startTimer()
    }

    func completeTask() {
        timer?.invalidate()
        isStarted = false
        isRunning = false
        timeRemaining = 1200
        progress = 0.0
    }

    func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview("TodoTimer") {
    TodoTimer(todo: .constant(Todo(title: "TodoTimer", requiredTime: 0, createdAt: Date.now)))
}

