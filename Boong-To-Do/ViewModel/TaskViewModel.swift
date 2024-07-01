//
//  TaskViewModel.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/21/24.
//

import Foundation

class TaskViewModel: ObservableObject {
    
    private var model = UserInfo()
    @Published var completeTasks: [Todo] = []
    @Published var notCompleteTasks: [Todo] = []

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
    }
    
    // TODO: 할일 저장 함수 완성하기
    func getSaveTask(title: String, content: String?, time: Int) {
        self.model.tasks?.append(Todo(title: title, content: content, requiredTime: time, createdAt: Date.now))
        print("title:\(title)")
        print("content:\(String(describing: content))")
        print("time:\(time)")
        getTaskStates()
    }
    
    /**입력한 시간을 초 단위로 바꿔 저장하는 함수*/
    func getRequiredTime(hours: Int, minutes: Int) -> Int{
        return ((hours * 3600) + (minutes * 60))
    }
}
