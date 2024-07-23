//
//  Boong_To_DoApp.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/10/24.
//

import SwiftUI

@main
struct Todo_TycoonApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var viewModel = TodoViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
                .onChange(of: scenePhase) { _, newValue in
                    switch newValue {
                    case .active:
                        viewModel.getObject()
                        viewModel.fetchDate()
                        viewModel.fetchTodo()
                    case .background:
                        viewModel.setObject()
                    case .inactive:
                        break
                    default:
                        break
                    }
                }
        }
    }
}
