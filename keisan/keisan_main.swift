//
//  keisan_main.swift
//  keisan
//
//  Created by 牛田啓介 on 2025/07/20.
//

import SwiftUI

struct keisan_main: View {
    // 設定情報
    @Binding var max_element_num: String
    @Binding var max_line_num: String
    // 横マス用の配列
    @State var randArray1:[Int]  = []
    // 縦マス用の配列
    @State var randArray2:[Int]  = []
    // ユーザー入力用の配列
    @State var ansArray:[[ans_cell]] = []
    // ユーザー入力用構造体
    struct ans_cell : Identifiable{
        let id = UUID()
        var answer:String = ""
        var user_ans:String = ""
        var result:String = "➖"
    }
    @State var collect_rate: Int = 0
    @State var result_str: String = ""
    @State var isModalPresented = false
    var version_str = "1.01"
    // 縦横の配列を作成
    func createRandArray(num:Int,max:Int) -> [Int] {
        print("createRandArray_start")
        var rand:[Int]  = []
        for _ in 0...num-1 {
            rand.append(Int.random(in: 1...max))
        }
        print(rand)
        print("createRandArray_end")
        return rand
    }
    // ユーザー回答を保持する配列を作成
    func createAnsCellArray(num:Int) -> [[ans_cell]] {
        print("createAnsCellArray_start")
        var rtn_ans:[[ans_cell]] = []
        randArray2.forEach { randnum2 in
            var ans:[ans_cell] = []
            for (_, randnum1) in randArray1.enumerated() {
                ans.append(ans_cell(answer: String(randnum1*randnum2)))
                print(String(randnum1*randnum2))
            }
            rtn_ans.append(ans)
        }
        print("createAnsCellArray_end")
        return rtn_ans
    }
    // ユーザー回答を確認
    func checkAns() -> (Int,String) {
        print("checkAns_start")
        var collect_ans_cnt = 0.0
        var all_cnt = 0.0
        var result_num = 0
        var result_str = ""
        $ansArray.forEach { $ans in
            $ans.forEach{ $ans2 in
                all_cnt += 1
                print("user_ans:\($ans2.user_ans.wrappedValue) answer:\($ans2.answer.wrappedValue)")
                if (Int($ans2.user_ans.wrappedValue) == Int($ans2.answer.wrappedValue)){
                    $ans2.result.wrappedValue = "⭕️"
                    collect_ans_cnt += 1
                }else if ($ans2.user_ans.wrappedValue == ""){
                    $ans2.result.wrappedValue = "➖"
                }else{
                    $ans2.result.wrappedValue = "✖️"
                }
            }
        }
        result_num = Int(floor((collect_ans_cnt/all_cnt)*100))
        if (result_num == 100){
            result_str = "はなまる"
        }else if (result_num >= 80){
            result_str = "よくがんばりました"
        }else if (result_num >= 50){
            result_str = "もうひといき"
        }else{
            result_str = "もうすこしがんばろう"
        }
        print("checkAns_end")
        return (result_num,result_str)
    }
    var body: some View {
        ScrollView([.vertical, .horizontal], showsIndicators: true) {
            Text("100マスけいさん ver.\(version_str)").font(.system(size: 24, weight: .bold))
                .onAppear {
                    // 画面用のデータを生成
                    randArray1 = createRandArray(num:Int(max_line_num) ?? 0, max:Int(max_element_num) ?? 0)
                    randArray2 = createRandArray(num:Int(max_line_num) ?? 0, max:Int(max_element_num) ?? 0)
                    ansArray = createAnsCellArray(num:Int(max_line_num) ?? 0)
                }
            // 画面の描画
            VStack {
                // 1行目の描画
                HStack {
                    Spacer().frame(width: 10)
                    Rectangle().frame(width: 70, height: 30)
                    ForEach(randArray1, id: \.self){ element in
                        ZStack {
                            Rectangle()
                                .frame(width: 70, height: 30)
                            Text(String(element))
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                // 2行目以降の描画
                ForEach(Array($ansArray.enumerated()), id: \.offset){ idx,$ans in
                    HStack {
                        Spacer().frame(width: 10)
                        ZStack {
                            Rectangle()
                                .frame(width: 70, height: 30)
                            Text(String(randArray2[idx]))
                                .foregroundColor(.white)
                        }
                        ForEach(Array($ans.enumerated()), id: \.offset){ idx2,$ans2 in
                            TextField(
                                "答え",
                                text: $ans2.user_ans
                            ).keyboardType(.numberPad).frame(width: 40, height: 30)
                            Text($ans2.result.wrappedValue)
                            Spacer()
                        }
                    }
                }
                // 回答チェックボタン
                HStack {
                    Button(action: {
                        isModalPresented = true
                        (collect_rate,result_str) = checkAns()
                        print("Checking Button tapped.")
                        print(collect_rate)
                    }) {
                        Text("こたえあわせ")
                    }.buttonStyle(BorderedButtonStyle())
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            // 結果表示用モーダル
            .sheet(isPresented: $isModalPresented) {
                keisan_result_modal(collect_rate: collect_rate,result_str: result_str)
            }
        }
    }
}

