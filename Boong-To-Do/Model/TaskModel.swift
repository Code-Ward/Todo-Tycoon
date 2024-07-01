//
//  TaskModel.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/30/24.
//

import Foundation

struct UserInfo {
    let id = UUID()
    let userID: String = "hamsik"
    let userPW: String = "passpass"// 암호화 필요
    var tasks: [Todo]? = []
}

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var content: String?
    var requiredTime: Int
    var executedTime: Int = 0
    var createdAt: Date
    var finishedAt: Date?
    var memo: [Memo]?
}

struct Memo {
    let id = UUID()
    var content: String
    var createdAt: Date
    var todoID: Todo
}
