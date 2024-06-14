//
//  TaskListView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/13/24.
//

import SwiftUI

/**할일 추가 완료 시, 할일 목록을 보여주는 화면*/
struct TaskListView: View {
    
    // TODO: 데이터 구조 설계하기
    var dummyTaskArray: [DummyTaskData] = [
        DummyTaskData(taskTitle: "기초디자인 포스터 1", taskDuration: 20, taskHasDone: false),
        DummyTaskData(taskTitle: "기초디자인 포스터 2", taskDuration: 40, taskHasDone: true),
        DummyTaskData(taskTitle: "할일 할일 할일 1", taskDuration: 20, taskHasDone: false),
        DummyTaskData(taskTitle: "할일 할일 할일 2", taskDuration: 30, taskHasDone: true)
    ]
    
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("\(dummyTaskArray.count)개의 할 일")
                    
                    Spacer()
                    
                    // TODO: 정렬 기능 구현하기
                    Text("정렬")
                    Image(systemName: "arrow.up.arrow.down")
                }
                .padding()
                
                ForEach(dummyTaskArray) { dummy in
                    TaskListCell(dummyTaskTitle: dummy.taskTitle, dummyTaskDuration: dummy.taskDuration, taskHasDone: dummy.taskHasDone)
                }
                
            }
        }
    }
}

#Preview("TaskList") {
    TaskListView()
}

struct TaskListCell: View {
    
    var dummyTaskTitle: String
    var dummyTaskDuration: Int
    @State var taskHasDone: Bool
    
    var body: some View {
            HStack {
                if taskHasDone {
                    Image(systemName: "checkmark.square")
                }else {
                    Image(systemName: "square")
                }
                
                Text(dummyTaskTitle)
                    .font(.system(size: 14))
                    .padding(.horizontal, 10)
                
                Spacer()
                
                Button(action: {}, label: {
                    Label("\(dummyTaskDuration)분", systemImage: "clock")
                        .font(.system(size: 10))
                        .foregroundStyle(.black)
                })
                .frame(width: 50, height: 18)
                .background(.gray).opacity(0.3)
                .clipShape(.rect(cornerRadius: 4))
                
            }
        .frame(width: .infinity, height: 27)
        .padding(20)
        .background(.white)
        .clipShape(.rect(cornerRadius: 12))
        .padding(10)
    }
}

#Preview("TaskCell") {
    TaskListCell(dummyTaskTitle: "기초 디자인 포스터", dummyTaskDuration: 20, taskHasDone: false)
}

struct DummyTaskData: Identifiable {
    let id = UUID()
    var taskTitle: String
    var taskDuration: Int
    var taskHasDone: Bool
}
