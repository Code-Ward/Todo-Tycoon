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
    var timer: Timer?
    @Published var completeTodos: [Todo] = []
    @Published var notCompleteTodos: [Todo] = []
    @Published var processingTodos: [Todo] = []
    @Published var dateInfo: [DateInfo] = []
    @Published var selectedDate: Date = Date.now
    @Published var presentationTime: Int = 0
    var excutedTime: Int = 0
    
    // MARK: - Todo 관련
    
    /**할일 저장을 저장하며 함수 호출 시, (createdAt: Date.now) 저장*/
    func addTodo(title: String, content: String?, time: Int, createdAt: Date) {
        self.model.todos?.append(Todo(title: title, content: content ?? "설명 없음", requiredTime: time, createdAt: createdAt))
        fetchTodo()
    }
    
    /// 완료 시 메모를 할일에 저장하는 함수
    func saveMemo(todo: UUID, memo: String) {
        if var todos = model.todos {
            if let index = model.todos?.firstIndex(where: { $0.id == todo}) {
                if ((todos[index].memo?.isEmpty) != nil) { todos[index].memo?.append(Memo(content: memo, createdAt: Date.now, todoID: todo))}
                else {
                    todos[index].memo = [Memo(content: memo, createdAt: Date.now, todoID: todo)]
                }
            }
            model.todos = todos
        }
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
    
    /// 할일을 완료 했을 때, 호출되는 함수
    ///
    /// 저장값
    /// - 완료시점: Date
    /// - 소요시간 : Int
    func todoHasDone(todo: Todo) {
        if self.timer != nil { self.timer?.invalidate() }
        if var todos = model.todos {
            if let index = model.todos?.firstIndex(where: { $0.id == todo.id}) {
                // 완료시점 저장
                todos[index].finishedAt = Date.now
                // 소요된 시간 저장
                todos[index].executedTime += self.excutedTime
            }
            model.todos = todos
            print("Todo Has Done!")
        }
    }
    
    func getTodoMemo(todo: Todo) -> [String] {
        var memos: [String] = []
        if let memo = todo.memo {
            for item in memo {
                memos.append(item.content)
            }
        }
        return memos
    }
    
    /**할일 데이터 업데이트*/
    func fetchTodo() {
        let calendar = Calendar.current
        self.completeTodos = []
        self.notCompleteTodos = []
        self.processingTodos = []
        
        if let todos = model.todos {
            for todo in todos {
                // 사용자 선택 날짜와 할일 생성 날짜를 비교
                if calendar.isDate(selectedDate, inSameDayAs: todo.createdAt) {
                    // 종료시점이 있다면 = 완료
                    if todo.finishedAt != nil {
                        self.completeTodos.append(todo)
                    } else {
                        // 소요된 시간이 없다면? = 할 일
                        if todo.executedTime == 0 {
                            self.notCompleteTodos.append(todo)
                        }
                        // 소요된 시간이 있다면 = 진행 중
                        if todo.executedTime > 0 {
                            self.processingTodos.append(todo)
                        }
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
    
    /// 할일의 남은 시간을 뷰에 세팅하는 함수
    ///
    ///입력받은 todo의 ID로 필요한 데이터를 model에서 찾고
    ///처음 세팅한 시간에서 기존에 실행한 시간을 뺀 값을
    ///presentationTime에 할당

    // 타이머가 나타나면 호출될 함수
    func setTimeData(todo: UUID) {
        if let todoIndex = notCompleteTodos.firstIndex( where: { $0.id == todo }) {
            let item = notCompleteTodos[todoIndex]
            let presentedTime = item.requiredTime - item.executedTime
            self.presentationTime = presentedTime
        }
    }
    
    // 타이머 시작
    func startTimer(todo: UUID){
        print("Timer Start!")
        excutedTime = 0
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self] _ in
            presentationTime -= 1
            excutedTime += 1
            print("Time Value: \(presentationTime)")
        })
    }
    
    /// 타이머 중지
    ///
    /// 타이머 인스턴스를 해제하고
    /// UUID를 통해 해당 할일의 소요시간을
    /// 현재 소요된 시간만큼 더한다.
    func stopTimer(todo: UUID) {
        self.timer?.invalidate()
        print("Timer Stopped!")
        if var todos = model.todos {
            if let index = model.todos?.firstIndex(where: { $0.id == todo }) {
                todos[index].executedTime += self.excutedTime
                print("\(self.excutedTime) has Saved!")
            }
            model.todos = todos
        }
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
    
    // 남은 시간 / 전체시간 = 남은 시간 비율
    func getTimePercent(todo: UUID) -> Double {
        if let todoIndex = notCompleteTodos.firstIndex( where: { $0.id == todo }) {
            let item = notCompleteTodos[todoIndex]
            let result = Double(Double(presentationTime) / Double(item.requiredTime))
            return result
        }
        return 0.0
    }
}
