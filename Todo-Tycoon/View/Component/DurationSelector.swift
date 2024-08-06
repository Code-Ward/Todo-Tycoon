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
    @State var minuteSelection = 15
    var hourArray = Array(0..<24)
    @Binding var todoRequiredTime: Int
    
    var body: some View {
        VStack {
            // X를 누르면 모달 Dismiss
            // 데이터를 저장
            
            
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
                    .onAppear {
                        if todoRequiredTime != 0 {
                            hourSelection = todoRequiredTime / 3600
                        }
                    }
                }
                .pickerStyle(.wheel)
                
                Text("시간")
                
                Picker("분 선택창", selection: $minuteSelection) {
                    if hourSelection < 1 {
                        let minuteArray = Array(1...59)
                        ForEach(minuteArray, id: \.self) { minute in
                            Text("\(minute)")
                        }
                        .onAppear(perform: {
                            if todoRequiredTime != 0 {
                                minuteSelection = ((todoRequiredTime % 3600) / 60)
                            }
                        })
                    }
                    else {
                        let minuteArray = Array(0...59)
                        ForEach(minuteArray, id: \.self) { minute in
                            Text("\(minute)")
                        }
                        .onAppear(perform: {
                            if todoRequiredTime != 0 {
                                minuteSelection = ((todoRequiredTime % 3600) / 60)
                            }
                        })
                    }
                }
                .pickerStyle(.wheel)
                
                Text("분")
            }
            
            .padding()
            
            Button(action: {
                isPresented.toggle()
                todoRequiredTime = viewModel.getRequiredTime(hours: hourSelection, minutes: minuteSelection)
            }, label: {
                Text("추가하러 가기")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                    .bold()
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 8))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
            })
        }
    }
}

#Preview {
    DurationSelector(isPresented: .constant(false), todoRequiredTime: .constant(5))
        .environmentObject(TodoViewModel())
}
