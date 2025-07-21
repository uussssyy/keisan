//
//  keisan_top.swift
//  keisan
//
//  Created by 牛田啓介 on 2025/07/20.
//

import SwiftUI

struct keisan_top: View {
    @State private var next_flg : Bool = false
    var body: some View {
        if next_flg {
            keisan_config()
        }else {
            ZStack {
                Image("keisan")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                Button {
                    next_flg = true
                } label: {
                    Text("タップでスタート").font(.system(size: 24, weight: .bold)).foregroundColor(.white)
                }
                
                
            }
        }
    }
}

