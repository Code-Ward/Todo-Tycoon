//
//  TaskTimer.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/14/24.
//

import SwiftUI

/**할일 시작 시, 보여지는 타이머 모달 화면*/
struct TaskDetail: View {
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    // TODO: 디자이너에게 물어봄
                }, label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.black)
                })
            }
            
            HStack {
                Text("기초디자인 포스터")
                    .font(.system(size: 16))
                    .bold()
                    .padding(.bottom, 10)
                Spacer()
            }
            
            HStack {
                Text("설명 설명 설명 설명 설명 설명 설명 설명 ")
                    .font(.system(size: 12))
                    .padding(.bottom, 15)
                Spacer()
            }
            
            HStack {
                Label(
                    // TODO: 예상소요시간 데이터 연동 필요
                    title: { Text("예상 소요 시간 20분") },
                    icon: { Image(systemName: "clock") }
                )
                .foregroundStyle(.gray)
                .padding()
                .frame(height: 40)
                .background(.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 4))
                
                Spacer()
            }
            .padding(.bottom, 40)
            
            TaskTimer()
            
        }
        .padding(.horizontal, 20)
    }
}

struct TaskTimer: View {
    
    // TODO: 데이터 연동하기
    @State var progress = 0.6
    
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
            
            Button(action: {
                // TODO: 타이머 시작하기
            }, label: {
                Text("타이머 시작하기")
                    .foregroundStyle(.white)
                    .bold()
                    .frame(width: 140)
                    .padding()
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 100))
            })
            .padding(.top, 20)
        }
    }
}

#Preview("TaskDetail") {
    TaskDetail()
}

#Preview("TaskTimer") {
    TaskTimer()
}
