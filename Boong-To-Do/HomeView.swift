//
//  ContentView.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/10/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
            VStack {
                HStack {
                    Text("LOGO")
                        .bold()
                        .font(.system(size: 16))
                        .frame(width: 48, height: 24)
                    
                    Spacer()
                    
                    Button(action: {}, label: {
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
                EmptyListView()
            }
    }
}

#Preview {
    HomeView()
}
