//
//  MockData.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/18/24.
//

import Foundation

struct MockTaskData: Identifiable {
    let id = UUID()
    var taskTitle: String = "제목"
    var taskDescription = ""
    var taskDuration: Int = 0
    var taskHasDone: Bool = false
    
    static var mockTaskArray: [MockTaskData] = [
        MockTaskData(taskTitle: "기초디자인 포스터 1", taskDuration: 20, taskHasDone: false),
        MockTaskData(taskTitle: "기초디자인 포스터 2", taskDuration: 40, taskHasDone: true),
        MockTaskData(taskTitle: "할일 할일 할일 1", taskDuration: 20, taskHasDone: false),
        MockTaskData(taskTitle: "할일 할일 할일 2", taskDuration: 30, taskHasDone: true)
    ]
}
