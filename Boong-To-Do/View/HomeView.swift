//
//  ContentView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/10/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = TaskViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("LOGO")
                    .bold()
                    .font(.system(size: 16))
                    .frame(width: 48, height: 24)
                
                Spacer()
                
                Button(action: {
                    // TODO: 버튼을 누르면 어떤 기능?
                }, label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.black)
                })
            }
            .padding()
            
            DateSelector()
                .padding(.bottom, 10)
                .scrollIndicators(.hidden)
                .onAppear {
                    viewModel.getTaskStates()
                }
            if !viewModel.notCompleteTasks.isEmpty || !viewModel.completeTasks.isEmpty {
                TaskListView(viewModel: viewModel)
            } else {
                EmptyListView()
            }
        }
    }
}

#Preview() {
    HomeView()
}
