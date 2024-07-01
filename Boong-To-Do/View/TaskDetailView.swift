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
struct TaskDetailView: View {
    var body: some View {
        VStack {
        // TODO: 뷰에서 표시할 데이터를 전달해야함
            TaskInfo()
            
            TaskTimer()
            
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    TaskDetailView()
}
