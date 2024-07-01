//
//  TaskViewModel.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/21/24.
//

import Foundation

class TaskViewModel: ObservableObject {
    
    private var model = UserInfo()
    private var mockModel = MockTaskData()
    @Published var completeTasks: [Todo] = []
    @Published var notCompleteTasks: [Todo] = []
    @Published var mockCompleteTasks: [MockTaskData] = []
    @Published var mockNotCompleteTasks: [MockTaskData] = []
    
    func getTaskStates() {
        if let tasks = model.tasks {
            for task in tasks {
                if task.finishedAt == nil {
                    self.notCompleteTasks.append(task)
                } else {
                    self.completeTasks.append(task)
                }
            }
        }
        
        for task in MockTaskData.mockTaskArray {
            if task.taskHasDone {
                self.mockCompleteTasks.append(task)
            } else {
                self.mockNotCompleteTasks.append(task)
            }
        }
    }
    
    // TODO: 할일 저장 함수 완성하기
    func getSaveTask(title: String, content: String?, time: Int) {
        model.tasks?.append(Todo(title: title, requiredTime: time, createdAt: Date.now))
    }
}
