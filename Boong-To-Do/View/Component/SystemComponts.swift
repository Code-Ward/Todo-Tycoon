//
//  SystemComponts.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/25/24.
//

import SwiftUI

/**기본적으로 사용되는 뷰 컴포넌트들*/
struct SystemComponts: View {
    var body: some View {
        VStack {
            Text("dd")
            TextButton()
            SystemImageButton()
        }
    }
}

/**글자가 포함된 텍스트박스*/
struct TextButton: View {
    
    var content: String = "Text"
    
    var body: some View {
        // TODO: 타이머 시작하기
        Text("\(content)")
            .foregroundStyle(.white)
            .bold()
            .frame(width: 140)
            .padding()
            .background(.black)
            .clipShape(.rect(cornerRadius: 100))
    }
}

struct SystemImageButton: View {
    
    var systemImageName: String = "plus"
    var width: CGFloat = 24.0
    var height: CGFloat = 24.0
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: width, height: height)
            .foregroundStyle(.white)
            .frame(width: width * 2, height: height * 2)
            .background(.black)
            .clipShape(Circle())
    }
}

#Preview {
    SystemComponts()
}
