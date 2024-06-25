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
                Spacer()
                Menu {
                    Button(role: .destructive, action: {
                        print("삭제하기 성공")
                    }, label: {
                        Label("삭제하기", systemImage: "trash")
                    })
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.black)
                }
            }
            .padding(.top, 20)

            HStack {
                Text("\(title)")
                    .font(.system(size: 16))
                    .bold()
                    .frame(width: .infinity, height: 24)
                Spacer()
            }
            
            HStack {
                Text("\(description)")
                    .font(.system(size: 12))
                    .frame(minHeight: 50, alignment: .top)
                    .lineLimit(8)
                
                Spacer()
            }
            
            HStack {
                Label(
                    // TODO: 예상소요시간 데이터 연동 필요
                    title: { 
                        Text("예상 소요 시간 \(time)분")
                            .font(.system(size: 12))
                    },
                    icon: { 
                        Image(systemName: "clock")
                            .frame(width: 18, height: 18)
                    }
                )
                .foregroundStyle(.gray)
                .frame(width: 140, height: 30)
                .background(.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 4))
                
                Spacer()
            }
            Spacer()
        }
    }
}
#Preview("TaskDetail") {
    TaskDetail()
}
