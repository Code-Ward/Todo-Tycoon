//
//  ContentView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/10/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: TodoViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("LOGO")
                    .bold()
                    .font(.system(size: 16))
                    .frame(width: 48, height: 24)
                
                Spacer()
                
                Button(action: {
                    // TODO: 기능 미정
                }, label: {
                    Image(systemName: SystemImage.ellipsis.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.black)
                })
            }
            .onAppear {
                viewModel.fetchDate()
                viewModel.fetchTodo()
            }
            .padding()
            
            DateSelector()
                .padding(.bottom, 10)
                .scrollIndicators(.hidden)
            
            if viewModel.notCompleteTodos.isEmpty && viewModel.completeTodos.isEmpty && viewModel.processingTodos.isEmpty{
                EmptyListView()
            } else {
                TodoListView()
            }
        }
    }
}

#Preview() {
    HomeView()
}
