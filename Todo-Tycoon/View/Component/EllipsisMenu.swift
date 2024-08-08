//
//  EllipsisMenu.swift
//  Boong-To-Do
//
//  Created by 황석현 on 7/2/24.
//

import SwiftUI

/**메뉴: 입력 기능 작동*/
struct EllipsisMenu: View {
    
    var body: some View {
        Image(systemName: SystemImage.ellipsis.name)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundStyle(.black)
    }
}

#Preview("EllipsisMenu") {
    EllipsisMenu()
}
