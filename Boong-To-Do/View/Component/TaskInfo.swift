//
//  TaskDetail.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/25/24.
//

import SwiftUI

/**할일 상세사항을 보여주는 뷰*/
struct TaskInfo: View {
    
    @State var title: String = "제목"
    @State var description: String = "설명"
    @State var time: Int = 1
    @State var isPresented = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    
                }, label: {
                    EllipsisMenu(isPresented: false)
                })
            }

            HStack {
                Text("\(title)")
                    .font(.system(size: 16))
                    .bold()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 24)
            
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

/**메뉴: 삭제하기*/
struct EllipsisMenu: View {
    
    @State var isPresented = false
    
    var body: some View {
        Menu {
            Button(role: .destructive, action: {
                isPresented.toggle()
            }, label: {
                Label("삭제하기", systemImage: SystemImage.trash.name)
            })
        } label: {
            Image(systemName: SystemImage.ellipsis.name)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(.black)
        }
        .alert(isPresented: $isPresented) {
            let deleteButton = Alert.Button.default(Text("취소")) {
                isPresented.toggle()
            }
            let cancelButton = Alert.Button.cancel(Text("삭제하기")) {
                // TODO: 데이터 삭제기능 추가
                print("데이터 삭제")
            }
            return Alert(title: Text("할 일 삭제"), message: Text("할일을 정말 삭제하시겠습니까?"), primaryButton: cancelButton, secondaryButton: deleteButton)
        }
    }
}

#Preview("TaskDetail") {
    TaskInfo()
}

#Preview("ElipsisMenu") {
    EllipsisMenu()
}
