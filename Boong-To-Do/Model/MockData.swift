//
//  MockData.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/18/24.
//

import Foundation

struct MockTaskData: Identifiable {
    let id = UUID()
    var taskTitle: String
    var taskDuration: Int
    var taskHasDone: Bool
}
