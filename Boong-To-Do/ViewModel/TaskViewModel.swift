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
    
    
    // MARK: 할일 저장
    /**할일 저장을 저장하며 함수 호출 시, (createdAt: Date.now) 저장*/
    // TODO: createdAt 입력값 수정
    func saveTask(title: String, content: String?, time: Int) {
        self.model.tasks?.append(Todo(title: title, requiredTime: time, createdAt: Date.now))
        fetchTaskData()
    }
    
    // MARK: 할일 삭제
    /**UUID를 입력받아 해당 요소를 찾아 삭제하는 함수*/
    func deleteTask(id: UUID) {
        if let index = model.tasks?.firstIndex(where: { $0.id == id }) {
            print("index : \(index)")
            model.tasks?.remove(at: index)
        }
        fetchTaskData()
        print("notCompleteTasks : \(notCompleteTasks.count)")
    }
    
    // MARK: 입력 시간을 초 단위로 변경
    /**입력한 시간을 초 단위로 바꿔 저장하는 함수*/
    func getRequiredTime(hours: Int, minutes: Int) -> Int{
        return ((hours * 3600) + (minutes * 60))
    }
    
    // MARK: 뷰 데이터 업데이트
    /**뷰에 사용될 데이터 업데이트*/
    func fetchTaskData() {
        self.completeTasks = []
        self.notCompleteTasks = []
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
}
