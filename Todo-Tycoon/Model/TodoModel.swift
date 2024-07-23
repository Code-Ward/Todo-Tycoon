//
//  TodoModel.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/30/24.
//

import Foundation

struct UserInfo: Codable {
    let id: UUID
    var userID: String
    var userPW: String // 암호화 필요
    var todos: [Todo]? = []
    
    init(id: UUID = UUID(), userID: String = "hamsik", userPW: String = "passpass", todos: [Todo]? = []) {
        self.id = id
        self.userID = userID
        self.userPW = userPW
        self.todos = todos
    }
}

struct Todo: Codable, Identifiable {
    let id: UUID
    var title: String
    var content: String
    var requiredTime: Int
    var executedTime: Int
    var createdAt: Date
    var finishedAt: Date?
    var memo: [Memo]?
    
    init(id: UUID = UUID(), title: String, content: String = "", 
         requiredTime: Int, executedTime: Int = 0, createdAt: Date, finishedAt: Date? = nil, memo: [Memo]? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.requiredTime = requiredTime
        self.executedTime = executedTime
        self.createdAt = createdAt
        self.finishedAt = finishedAt
        self.memo = memo
    }
}

struct Memo: Codable, Hashable {
    let id: UUID
    var content: String
    var createdAt: Date
    var todoID: UUID
    
    init(id: UUID = UUID(), content: String, createdAt: Date, todoID: UUID) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
        self.todoID = todoID
    }
}

struct DateInfo: Codable, Identifiable {
    let id: UUID
    var date: Date
    var monthString: String
    var dayString: String
    var weekdayString: String
    
    init(id: UUID = UUID(), date: Date, monthString: String, dayString: String, weekdayString: String) {
        self.id = id
        self.date = date
        self.monthString = monthString
        self.dayString = dayString
        self.weekdayString = weekdayString
    }
}
