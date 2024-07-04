//
//  TodoViewModel.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/21/24.
//

import Foundation

class TodoViewModel: ObservableObject {
    
    private var model = UserInfo()
    var today = Date()
    @Published var completeTodos: [Todo] = []
    @Published var notCompleteTodos: [Todo] = []
    @Published var dateInfo: [DateInfo] = []
    @Published var selectedDate: Date = Date.now
    @Published var presentationTime: Int = 0
    var excutedTime: Int = 0
    
    // MARK: - Todo 관련
    
    /**할일 저장을 저장하며 함수 호출 시, (createdAt: Date.now) 저장*/
    func saveTodo(title: String, content: String?, time: Int, createdAt: Date) {
        self.model.todos?.append(Todo(title: title, content: content ?? "설명 없음", requiredTime: time, createdAt: createdAt))
        fetchTodo()
    }
    
    func changeTodoTitle(todo: Todo, title: String) {
        if var todos = model.todos {
            if let index = model.todos?.firstIndex(where: { $0.id == todo.id}) {
                todos[index].title = title
            }
            model.todos = todos
        }
        fetchTodo()
    }
    
    func changeTodoContent(todo: Todo, content: String) {
        if var todos = model.todos {
            if let index = model.todos?.firstIndex(where: { $0.id == todo.id}) {
                todos[index].content = content
            }
            model.todos = todos
        }
        fetchTodo()
    }
    
    func changeTodoRequiredTime(todo: Todo, requiredTime: Int) {
        if var todos = model.todos {
            if let index = model.todos?.firstIndex(where: { $0.id == todo.id}) {
                todos[index].requiredTime = requiredTime
            }
            model.todos = todos
        }
        fetchTodo()
    }
    
    /**UUID를 입력받아 해당 요소를 찾아 삭제하는 함수*/
    func deleteTodo(id: UUID) {
        if let index = model.todos?.firstIndex(where: { $0.id == id }) {
            model.todos?.remove(at: index)
        }
        fetchTodo()
    }
    
    /**입력한 시간을 초 단위로 바꿔 저장하는 함수*/
    // TODO: 단위 수정 필요
    func getRequiredTime(hours: Int, minutes: Int) -> Int{
        return ((hours * 3600) + (minutes * 60))
    }
    
    func todoHasDone(todo: Todo) {
        if var todos = model.todos {
            if let index = model.todos?.firstIndex(where: { $0.id == todo.id}) {
                todos[index].finishedAt = Date.now
            }
            model.todos = todos
        }
    }
    
    /**할일 데이터 업데이트*/
    func fetchTodo() {
        let calendar = Calendar.current
        self.completeTodos = []
        self.notCompleteTodos = []
        
        // 사용자 선택 날짜와 할일 생성 날짜를 비교
        if let todos = model.todos {
            for todo in todos {
                if calendar.isDate(selectedDate, inSameDayAs: todo.createdAt) {
                    if todo.finishedAt == nil {
                        self.notCompleteTodos.append(todo)
                    } else {
                        self.completeTodos.append(todo)
                    }
                }
            }
        }
        print("Fetch Todo")
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
    
    // MARK: - 타이머 관련
    
    func setTimeData(todo: UUID) {
        if let todoIndex = notCompleteTodos.firstIndex(where: { $0.id == todo }) {
            let item = notCompleteTodos[todoIndex]
            presentationTime = item.requiredTime - item.executedTime
        }
    }
    
    func startTimer(todo: UUID){
        if let todoIndex = notCompleteTodos.firstIndex(where: { $0.id == todo }) {
            var item = notCompleteTodos[todoIndex]
            presentationTime = item.requiredTime - item.executedTime
            item.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
                    presentationTime -= 1
                    excutedTime += 1
            }
        }
    }
    
    func stopTimer(todo: UUID) {
        if let todoIndex = notCompleteTodos.firstIndex( where: { $0.id == todo }) {
            let item = notCompleteTodos[todoIndex]
            item.timer?.invalidate()
            if let modelIndex = notCompleteTodos.firstIndex(where: {$0.id == todo }) {
                var modelTodo = model.todos?[modelIndex]
                modelTodo?.executedTime = self.presentationTime
            }
        }
        fetchTodo()
    }
    
    func formatTime() -> String {
        let minute = abs(presentationTime) / 60
        let second = abs(presentationTime) % 60
        return String(format: "%02d:%02d", minute, second)
    }
    
    func formatMinute() -> String {
        let minute = abs(presentationTime) / 60
        return String(format: "약 %02d분", minute)
    }
    
    func getTimePercent(todo: UUID) -> Double{
        if let todoIndex = notCompleteTodos.firstIndex( where: { $0.id == todo }) {
            let item = notCompleteTodos[todoIndex]
            let result = Double(Double(presentationTime) / Double(item.requiredTime))
            print(result)
            return result
        }
        return 0.0
    }
}
