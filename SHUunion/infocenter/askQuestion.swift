//
//  askQuestion.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/7/5.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct askQuestion : View {
    @State var question = ""
    @State var showAlert = false
    @EnvironmentObject var userdata:UserData
    var body: some View {
        VStack{
            TextField(self.$question, placeholder: Text("请输入你的问题"))
            .padding()
            .frame(height: 500)
            Spacer()
            Button(action: {
                self.showAlert = true
                print("Tap")
                self.userdata.postMessage(id: self.userdata.infoDatas.id, content: self.question)
            }) {
                Text("提问")
                    .font(.system(size: 20,
                                  design: .rounded)).fontWeight(.bold)
                    .color(Color.white)
                    .frame(width: UIScreen.main.bounds.width-30,
                           height: 45)
                }.presentation($showAlert, alert: {
                    Alert(title: Text("已提交"),
                          message: Text("请在提问记录中查看"),
                          primaryButton: .destructive(Text("确认")) {
                            print("转出中...")
                            
                        },
                          secondaryButton: .cancel())
                }).background(Color.blue)
                .cornerRadius(10)
                .padding(.bottom)
        }
    }
}

#if DEBUG
struct askQuestion_Previews : PreviewProvider {
    static var previews: some View {
        askQuestion()
    }
}
#endif
