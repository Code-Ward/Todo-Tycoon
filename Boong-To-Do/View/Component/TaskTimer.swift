//
//  TaskTimer.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/14/24.
//

import SwiftUI

/**할일을 진행할 때, 사용되는 타이머 컴포넌트*/
struct TaskTimer: View {
    
    // TODO: 데이터 연동하기
    @State var progress = 0.6
    @State var isStarted = false
    @State var isRunning = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .frame(width: 250, height: 250)
                    .foregroundColor(.gray)
                
                VStack {
                    // TODO: 데이터 연동하기
                    Text("20:00")
                        .font(.system(size: 70))
                        .foregroundStyle(.opacity(0.5))
                    // TODO: 데이터 연동하기
                    Text("20분")
                        .font(.system(size: 16))
                        .foregroundStyle(.opacity(0.5))
                }
                .padding(40)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .frame(width: 250, height: 250)
                    .foregroundColor(Color(.black))
                    .rotationEffect(Angle(degrees: 270.0))
            }
            // TODO: 타이머 시작하면, 버튼 2개 생성(재생/정지, 할일 완료)
            if !isStarted {
                Button(action: {
                    isStarted.toggle()
                }, label: {
                    TextButton(content: "타이머 시작하기")
                        .padding(.vertical, 20)
                })
            } else {
                HStack {
                    // TODO: if Timer.invalid() 추가
                    if isRunning {
                        Button(action: {
                            // TODO: 타이머 재실행
                            isRunning.toggle()
                        }, label: {
                            SystemImageButton(imageName: SystemImage.play.name, width: 12, height: 12)
                        })
                    } else {
                        Button(action: {
                            // TODO: 타이머 정지
                            isRunning.toggle()
                        }, label: {
                            SystemImageButton(imageName: SystemImage.pause.name, width: 12, height: 12)
                        })
                    }
                    Button {
                        
                    } label: {
                        TextButton(content: "할 일 완료")
                    }
                }
                .padding(.vertical, 20)
            }
        }
    }
}

#Preview("TaskTimer") {
    TaskTimer()
}

#Preview("TaskProcessView") {
    TaskProcessView()
}

