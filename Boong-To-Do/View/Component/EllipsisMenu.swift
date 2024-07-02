//
//  EllipsisMenu.swift
//  Boong-To-Do
//
//  Created by 황석현 on 7/2/24.
//

import SwiftUI

/**메뉴: 삭제하기*/
struct EllipsisMenu: View {
    
    @State var isPresented = false
    var action: () -> Void
    
    var body: some View {
        Menu {
            
            Button(role: .destructive, action: {
                isPresented.toggle()
            }, label: {
                Label("삭제하기", systemImage: SystemImage.trash.name)
            })
            
        } label: {
            Image(systemName: SystemImage.ellipsis.name)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(.black)
        }
        .alert(isPresented: $isPresented) {
            let deleteButton = Alert.Button.default(Text("취소")) {
                isPresented.toggle()
            }
            let cancelButton = Alert.Button.cancel(Text("삭제하기")) {
                action()
                isPresented.toggle()
            }
            return Alert(title: Text("할 일 삭제"), message: Text("할일을 정말 삭제하시겠습니까?"), primaryButton: cancelButton, secondaryButton: deleteButton)
        }
    }
}

#Preview("EllipsisMenu") {
    EllipsisMenu(action: { print("EllipsisMenu Preview!")})
}
