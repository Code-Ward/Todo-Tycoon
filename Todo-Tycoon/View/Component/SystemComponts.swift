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
            TextButton()
            SystemImageButton(imageName: SystemImage.plus.name)
        }
    }
}

/**글자가 포함된 텍스트박스*/
struct TextButton: View {
    
    var content: String = "Text"
    
    var body: some View {
        Text("\(content)")
            .foregroundStyle(.white)
            .bold()
            .frame(minWidth: 120)
            .padding()
            .background(.black)
            .clipShape(.rect(cornerRadius: 100))
    }
}

struct SystemImageButton: View {
    
    var imageName: String
    var width: CGFloat
    var height: CGFloat
    
    init(imageName: String, width: CGFloat = 24.0, height: CGFloat = 24.0) {
            self.imageName = imageName
            self.width = width
            self.height = height
        }
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: width, height: height)
            .foregroundStyle(.white)
            .frame(width: 48, height: 48)
            .background(.black)
            .clipShape(Circle())
    }
}

#Preview {
    SystemComponts()
}
