
//  HomeListView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/10/24.
//

import SwiftUI

/**날짜를 선택할 수 있는 스크롤뷰*/
struct DateSelector: View {
    
    @EnvironmentObject var viewModel: TodoViewModel
    
    var body: some View {
        VStack {
            // MARK: 월 단위 표시
            HStack {
                Button(action: {
                    viewModel.goNextWeekDate(type: false)
                }, label: {
                    Image(systemName: SystemImage.leftArrow.name)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.gray)
                        .padding(.leading)
                })
                
                if viewModel.dateInfo.first != nil {
                    Text(viewModel.dateInfo[0].monthString)
                        .font(.system(size: 16))
                        .bold()
                } else {
                    Text("")
                        .font(.system(size: 16))
                        .bold()
                }
                
                Button(action: {
                    viewModel.goNextWeekDate(type: true)
                }, label: {
                    Image(systemName: SystemImage.rightArrow.name)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.gray)
                })
                
                Spacer()
            }
            
            // MARK: 날짜 나열
            HStack {
                ForEach(viewModel.dateInfo) { day in
                    VStack {
                        Text(day.dayString)
                        Text(day.weekdayString)
                    }
                    .frame(width: 41, height: 47)
                    .foregroundStyle(viewModel.selectedDate == day.date ? Color.accentColor : Color.black)
                    .background(viewModel.selectedDate == day.date ? Color.gray.opacity(0.3) : Color.clear)
                    .clipShape(.rect(cornerRadius: 4))
                    .id(day.id)
                    .onTapGesture {
                        withAnimation {
                            viewModel.selectedDate = day.date
                        }
                        viewModel.fetchTodo()
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    DateSelector()
        .environmentObject(TodoViewModel())
}
