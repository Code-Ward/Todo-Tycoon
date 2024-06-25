//
//  Enums.swift
//  Boong-To-Do
//
//  Created by 황석현 on 6/25/24.
//

import Foundation

/**시스템 이미지 열거형
 
 */
enum SystemImage {
    case plus
    case play
    case pause
    case ellipsis
    case clock
    case alignArrow
    case leftArrow
    case rightArrow
    case xMark
    case trash
    
    var name: String {
        switch self {
        case .plus:
            "plus"
        case .play:
            "play.fill"
        case .pause:
            "pause.fill"
        case .ellipsis:
            "ellipsis"
        case .clock:
            "clock"
        case .alignArrow:
            "arrow.up.arrow.down"
        case .leftArrow:
            "arrowtriangle.left.fill"
        case .rightArrow:
            "arrowtriangle.right.fill"
        case .xMark:
            "xmark"
        case .trash:
            "trash"
        }
    }
}

