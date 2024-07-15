//
//  TimeSelector.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/12/24.
//

import SwiftUI

/**할일 추가 시, 예상 소요시간 선택 모달화면*/
struct DurationSelector: View {
    
    @EnvironmentObject var viewModel: TodoViewModel
    // 상위 뷰 모달상태
    @Binding var isPresented: Bool
    @State var hourSelection = 0
    @State var minuteSelection = 0
    var hourArray = Array(0..<24)
    var minuteArray = Array(0..<60)
    @Binding var todoRequiredTime: Int
    
    var body: some View {
        VStack {
            // X를 누르면 모달 Dismiss
            // 데이터를 저장
            Button(action: {
                isPresented.toggle()
                todoRequiredTime = viewModel.getRequiredTime(hours: hourSelection, minutes: minuteSelection)
            }, label: {
                HStack {
                    Spacer()
                    
                    Image(systemName: SystemImage.xMark.name)
                        .padding(.horizontal)
                        .foregroundStyle(.black)
                        .bold()
                }
            })
            
            HStack {
                Text("예상 소요 시간")
                    .padding()
                    .bold()
                
                Spacer()
            }
            
            HStack {
                Picker("시간 선택창", selection: $hourSelection) {
                    ForEach(hourArray, id: \.self) { hour in
                        Text("\(hour)")
                    }
                }
                .pickerStyle(.wheel)
                
                Text("시간")
                
                Picker("분 선택창", selection: $minuteSelection) {
                    let minuteArray = Array(0..<60)
                    ForEach(minuteArray, id: \.self) { minute in
                        Text("\(minute)")
                    }
                    .onAppear(perform: {
                        minuteSelection = 15
                    })
                }
                .pickerStyle(.wheel)
                
                Text("분")
            }
            .padding()
        }
    }
}

#Preview {
    DurationSelector(isPresented: .constant(false), todoRequiredTime: .constant(5))
        .environmentObject(TodoViewModel())
}
