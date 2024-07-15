//
//  TodoModel.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/30/24.
//

import Foundation

struct UserInfo {
    let id = UUID()
    let userID: String = "hamsik"
    let userPW: String = "passpass"// 암호화 필요
    var todos: [Todo]? = []
}

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var content: String = ""
    var requiredTime: Int
    var executedTime: Int = 0
    // TODO: 날짜 지정입력 하기
    var createdAt: Date
    var finishedAt: Date?
    var memo: [Memo]?
}

struct Memo: Hashable {
    let id = UUID()
    var content: String
    var createdAt: Date
    var todoID: UUID
}

struct DateInfo: Identifiable {
    let id = UUID()
    var date: Date
    var monthString: String
    var dayString: String
    var weekdayString: String
}
