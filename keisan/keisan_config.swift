//
//  keisan_config.swift
//  keisan
//
//  Created by 牛田啓介 on 2025/07/20.
//

import SwiftUI

struct keisan_config: View {
    @State private var max_element_num : String = "9"
    @State private var max_line_num : String = "4"
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Text("かける数のさいだいち：")
                    TextField(
                        "さいだいち",
                        text: $max_element_num
                    ).keyboardType(.numberPad).frame(width: 80, height: 30)
                }
                HStack{
                    Text("タテヨコのマスの数：")
                    TextField(
                        "マスの数",
                        text: $max_line_num
                    ).keyboardType(.numberPad).frame(width: 80, height: 30)
                }
                NavigationLink(destination: keisan_main(max_element_num: $max_element_num,max_line_num:$max_line_num)) {
                    Text("れんしゅうスタート")
                }
            }
        }
    }
}
