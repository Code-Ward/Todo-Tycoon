//
//  TaskDetail.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/25/24.
//

import SwiftUI

/**할일 상세사항을 보여주는 뷰*/
struct TodoInfo: View {
    
    @Binding var todo: Todo
    
    var body: some View {
        VStack {
            HStack {
                Text("\(todo.title)")
                    .font(.system(size: 16))
                    .bold()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 24)
            
            HStack {
                Text("\(todo.content)")
                    .font(.system(size: 12))
                    .frame(minHeight: 50, alignment: .top)
                    .lineLimit(8)
                
                Spacer()
            }
            
            HStack {
                Label(
                    // TODO: 예상소요시간 데이터 연동 필요
                    title: { 
                        Text("예상 소요 시간 \(todo.requiredTime)분")
                            .font(.system(size: 12))
                    },
                    icon: { 
                        Image(systemName: SystemImage.clock.name)
                            .frame(width: 18, height: 18)
                    }
                )
                .foregroundStyle(.gray)
                .frame(width: 140, height: 30)
                .background(.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 4))
                
                Spacer()
            }
        }
    }
}

#Preview("TaskDetail") {
    TodoInfo(todo: .constant(Todo(title: "TaskDetail", requiredTime: 12, createdAt: Date())))
}


