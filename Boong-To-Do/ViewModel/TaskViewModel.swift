//
//  TaskViewModel.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/21/24.
//

import Foundation

class TaskViewModel: ObservableObject {
    
    private var model = MockTaskData()
    @Published var completeTasks: [MockTaskData] = []
    @Published var notCompleteTasks: [MockTaskData] = []
    
    func getTaskStates() {
        for item in MockTaskData.mockTaskArray {
            if item.taskHasDone { 
                completeTasks.append(item)
            } else {
                notCompleteTasks.append(item)
            }
        }
    }
}
