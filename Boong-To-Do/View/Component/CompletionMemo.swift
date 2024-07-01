//
//  CompletionMemo.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/25/24.
//

import SwiftUI

/**할일 완료시 메모를 작성하는 화면*/
struct CompletionMemo: View {
    
    @State var inputMemo = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            TaskInfo()
            
            Text("메모")
                .foregroundStyle(.secondary)
            
            TextField(text: $inputMemo) {
                Text("완료한 메모 작성해주세요")
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 216, alignment: .top)
            .background(.textBox)
            .clipShape(.rect(cornerRadius: 12))
        }
        .padding()
    }
}

#Preview {
    CompletionMemo()
}
