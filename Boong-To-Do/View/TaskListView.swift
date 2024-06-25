//
//  TaskListView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/13/24.
//

import SwiftUI

/**할일 추가 완료 시, 할일 목록을 보여주는 화면*/
struct TaskListView: View {
    
    @State var isPresented = false
    @ObservedObject var viewModel: TaskViewModel
    @State var addTaskIsPresented = false
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    // MARK: 미완료 할일 리스트
                    Section {
                        ForEach(viewModel.notCompleteTasks) { dummy in
                            TaskListCell(taskTitle: dummy.taskTitle, taskDuration: dummy.taskDuration, taskHasDone: dummy.taskHasDone)
                                .sheet(isPresented: $isPresented, content: {
                                    TaskDetail()
                                        .presentationDetents([.height(580)])
                                        .presentationDragIndicator(.visible)
                                })
                        }
                        .onTapGesture { isPresented.toggle() }
                    } header: {
                        HStack {
                            Text("\(viewModel.notCompleteTasks.count)개의 할 일")
                            
                            Spacer()
                            
                            // TODO: 정렬 기능 구현하기
                            Text("정렬")
                            Image(systemName: "arrow.up.arrow.down")
                        }
                        .padding()
                    }
                    // MARK: 완료 할일 리스트
                    Section {
                        ForEach(viewModel.completeTasks) { dummy in
                            TaskListCell(taskTitle: dummy.taskTitle, taskDuration: dummy.taskDuration, taskHasDone: dummy.taskHasDone)
                                .sheet(isPresented: $isPresented, content: {
                                    TaskDetail()
                                        .presentationDetents([.height(580)])
                                        .presentationDragIndicator(.visible)
                                })
                        }
                        .onTapGesture {
                            isPresented.toggle()
                        }
                    } header: {
                        HStack {
                            Text("완료")
                            
                            Spacer()
                        }
                        .padding()
                    }
                    
                    
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
                            Image(systemName: "plus")
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
                        AddTaskView(addTaskModalViewIsPresented: $addTaskIsPresented)
                            .presentationDetents([.height(200)])
                            .presentationDragIndicator(.visible)
                    })
                }
            }
            
        }
    }
}

#Preview("TaskList") {
    TaskListView(viewModel: TaskViewModel())
}

struct TaskListCell: View {
    
    var taskTitle: String
    var taskDuration: Int
    @State var taskHasDone: Bool
    
    var body: some View {
        HStack {
            if taskHasDone {
                Image(systemName: "checkmark.square.fill")
                    .foregroundStyle(taskHasDone ? .secondaryText.opacity(0.5) : .primaryText)
            }else {
                Image(systemName: "square")
            }
            
            Text(taskTitle)
                .font(.system(size: 14))
                .foregroundStyle(taskHasDone ? .secondaryText : .primaryText)
                .padding(.horizontal, 10)
            
            Spacer()
            
            Button(action: {}, label: {
                Label("\(taskDuration)분", systemImage: "clock")
                    .font(.system(size: 10))
                    .foregroundStyle(.black)
            })
            .frame(width: 50, height: 18)
            .background(.gray).opacity(0.3)
            .clipShape(.rect(cornerRadius: 4))
            
        }
        .padding(20)
        .background(taskHasDone ? .secondaryText.opacity(0.1) : .white)
        .clipShape(.rect(cornerRadius: 12))
        .padding(.horizontal, 10)
    }
}

#Preview("NotDoneTaskCell") {
    TaskListCell(taskTitle: "기초 디자인 포스터", taskDuration: 20, taskHasDone: false)
}
#Preview("HasDoneTaskCell") {
    TaskListCell(taskTitle: "기초 디자인 포스터", taskDuration: 20, taskHasDone: true)
}
