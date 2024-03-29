//
//  infoPage.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct infoPage : View {

    var info:info
    var body: some View {
        NavigationView{
        VStack{
        infobar(info: info)
            
            List{
                NavigationButton(destination: askQuestion()){
                    Image(systemName: "questionmark.square.fill")
                    Text("我要提问")}
                NavigationButton(destination: messagePage()){
                    Image(systemName: "list.dash")
                    Text("提问记录")}
                
                }.listStyle(.grouped)
        }.navigationBarTitle(Text("个人资料"), displayMode: .large)
        
           
        }

        
        
    }
}

#if DEBUG
struct infoPage_Previews : PreviewProvider {
    static var previews: some View {
        infoPage(info:infoData)
    }
}
#endif
