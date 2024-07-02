//
//  HomeListView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/10/24.
//

import SwiftUI

/**날짜를 선택할 수 있는 스크롤뷰*/
struct DateSelector: View {
    
    @State private var selectedDay: Int? = nil
    @State private var scrollViewHeight: CGFloat = 0.0
    
    // TODO: 데이터 구조 수정하기(6.2~7.27)
    // TODO: 일월화수목금토 순으로 수정
    // TODO: 버튼 터치 시 주단위로 변경(Drag X)
    let days = Array(1...30)
    let weekDays = ["일", "월", "화", "수", "목", "금", "토"]
    
    var body: some View {
        VStack {
            
            // MARK: 월 단위 표시
            HStack {
                Button(action: {
                    // TODO: 터치 시, 주 변경하기
                }, label: {
                    Image(systemName: SystemImage.leftArrow.name)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.gray)
                        .padding(.leading)
                })
                
                // TODO: 데이터를 동적으로 변경되게 하기
                Text("6월")
                    .font(.system(size: 16))
                    .bold()
                
                Button(action: {
                    // TODO: 터치 시, 주 변경하기
                }, label: {
                    Image(systemName: SystemImage.rightArrow.name)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.gray)
                })
                
                Spacer()
            }
            
            // MARK: 날짜 나열
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(days, id: \.self) { day in
                            VStack {
                                // TODO: 날짜와 요일 연동하기
                                Text("\(weekDays[(day-1)%7])")
                                Text("\(day)")
                            }
                            .frame(width: 41, height: 47)
                            .foregroundStyle(self.selectedDay == day ? Color.accentColor : Color.black)
                            .background(self.selectedDay == day ? Color.gray.opacity(0.3) : Color.clear)
                            .clipShape(.rect(cornerRadius: 4))
                            .id(day)
                            .onTapGesture {
                                withAnimation {
                                    selectedDay = day
                                    // 선택한 날짜를 화면 중앙으로 이동
                                    proxy.scrollTo(day, anchor: .center)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DateSelector()
}
