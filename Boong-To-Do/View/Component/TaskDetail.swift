//
//  TaskDetail.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/25/24.
//

import SwiftUI

/**할일 상세사항을 보여주는 뷰*/
struct TaskDetail: View {
    
    var title: String = "기초디자인 포스터"
    var description: String = "설명 설명 설명 설명 설명 설명 설명 설명"
    var time: Int = 20
    
    var body: some View {
        VStack {
            HStack {
                Text("\(title)")
                    .font(.system(size: 16))
                    .bold()
                    .padding(.bottom, 10)
                Spacer()
            }
            
            HStack {
                Text("\(description)")
                    .font(.system(size: 12))
                    .frame(maxHeight: 145, alignment: .top)
                    .padding(.bottom, 15)
                    .layoutPriority(1)
                
                Spacer()
            }
            
            HStack {
                Label(
                    // TODO: 예상소요시간 데이터 연동 필요
                    title: { 
                        Text("예상 소요 시간 \(time)분")
                    },
                    icon: { 
                        Image(systemName: "clock")
                    }
                )
                .foregroundStyle(.gray)
                .padding()
                .frame(height: 40)
                .background(.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 4))
                
                Spacer()
            }
        }
    }
}
#Preview("TaskDetail") {
    TaskDetail()
}
