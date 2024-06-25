//
//  TaskProcessView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/25/24.
//

import SwiftUI

/**할일 시작 시, 보여지는 타이머 화면(모달)
 
 할일 상세목록 + 타이머
 */
struct TaskProcessView: View {
    var body: some View {
        // TODO: 할일 상세사항을 보여주는 뷰를 만들어서 VStack으로 뷰1, 타이머 뷰로 감싼다.
        VStack {
            TaskDetail()
            
            TaskTimer()
            
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    TaskProcessView()
}
