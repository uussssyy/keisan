//
//  keisan_result_modal.swift
//  keisan
//
//  Created by 牛田啓介 on 2025/07/27.
//

import SwiftUI

struct keisan_result_modal: View {
    @Environment(\.dismiss) var dismiss
    let collect_rate:Int
    let result_str:String
    var body: some View {
        Text("あなたのせいとうりつは\(collect_rate)％です")
        Text("けいさんれんしゅうけっか：\(result_str)")
        Button("とじる") {
            dismiss()
        }
    }
}
