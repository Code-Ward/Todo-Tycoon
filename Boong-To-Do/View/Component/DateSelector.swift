//
//  HomeListView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/10/24.
//
// MARK: 날짜를 선택할 수 있는 스크롤뷰

import SwiftUI


struct DateSelector: View {
    
    @State private var selectedDay: Int? = nil
    @State private var scrollViewHeight: CGFloat = 0.0
    
    // TODO: 데이터 구조 수정하기
    let days = Array(1...30)
    let weekDays = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        VStack {
            // 월 단위 표시
            HStack {
                Button(action: {
                    // TODO: 터치 시, 월 변경할 수 있도록 하기
                }, label: {
                    Image(systemName: "arrowtriangle.left.fill")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.black)
                        .padding(.leading)
                })
                
                // TODO: 데이터를 동적으로 변경되게 하기
                Text("6월")
                    .font(.system(size: 16))
                    .bold()
                
                Button(action: {
                    // TODO: 터치 시, 월 변경하기
                }, label: {
                    Image(systemName: "arrowtriangle.right.fill")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.black)
                })
                
                Spacer()
            }
            // 날짜 나열
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(days, id: \.self) { day in
                            VStack {
                                // TODO: 날짜와 요일 연동하기
                                Text("\(weekDays[(day-1)%7])")
                                Text("\(day)")
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: 41, height: 47)
                            .foregroundColor(self.selectedDay == day ? Color.purple : Color.black)
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
