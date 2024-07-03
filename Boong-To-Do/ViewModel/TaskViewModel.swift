//
//  TaskViewModel.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/21/24.
//

import Foundation

class TaskViewModel: ObservableObject {
    
    private var model = UserInfo()
    var today = Date()
    @Published var completeTasks: [Todo] = []
    @Published var notCompleteTasks: [Todo] = []
    @Published var dateInfo: [DateInfo] = []
    
    // MARK: - Task 관련
    
    /**할일 저장을 저장하며 함수 호출 시, (createdAt: Date.now) 저장*/
    // TODO: createdAt 입력값 수정
    func saveTask(title: String, content: String?, time: Int) {
        self.model.tasks?.append(Todo(title: title, requiredTime: time, createdAt: Date.now))
        fetchTask()
    }
    
    /**UUID를 입력받아 해당 요소를 찾아 삭제하는 함수*/
    func deleteTask(id: UUID) {
        if let index = model.tasks?.firstIndex(where: { $0.id == id }) {
            print("index : \(index)")
            model.tasks?.remove(at: index)
        }
        fetchTask()
        print("notCompleteTasks : \(notCompleteTasks.count)")
    }
    
    /**입력한 시간을 초 단위로 바꿔 저장하는 함수*/
    // TODO: 단위 수정 필요
    func getRequiredTime(hours: Int, minutes: Int) -> Int{
        return ((hours * 3600) + (minutes * 60))
    }
    
    /**뷰에 사용될 데이터 업데이트*/
    func fetchTask() {
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
    
    // MARK: - Date 관련
    
    /**날짜 데이터 업데이트*/
    func fetchDate() {
        let calendar = Calendar.current
        dateInfo.removeAll()
        
        if let weekOfYear = calendar.dateInterval(of: .weekOfYear, for: today)?.start {
            let weeklyDates = (0..<7).compactMap {
                calendar.date(byAdding: .day, value: $0, to: weekOfYear)
            }
            // 한 주의 데이터를 문자열 형태의 월, 일, 요일로 저장
            for date in weeklyDates {
                dateInfo.append(DateInfo(date: date,
                                         monthString: formatMonth(date),
                                         dayString: formatDay(date),
                                         weekdayString: formatWeekday(date)))
            }
        }
    }
    
    /**주(날짜) 변경*/
    func goNextWeekDate(type: Bool) {
        let calendar = Calendar.current
        if type {
            if let newDate = calendar.date(byAdding: .day, value: 7, to: today) {
                today = newDate
            }
        } else {
            if let newDate = calendar.date(byAdding: .day, value: -7, to: today) {
                today = newDate
            }
        }
        fetchDate()
    }
    
    /**월 반환*/
    func formatMonth(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    /**일 반환*/
    func formatDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    /**요일 반환*/
    func formatWeekday(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}
