//
//  Boong_To_DoApp.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/10/24.
//

import SwiftUI

@main
struct Boong_To_DoApp: App {
    
    @StateObject var viewModel = TodoViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
