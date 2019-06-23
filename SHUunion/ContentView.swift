//
//  ContentView.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/19.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct mainpage:View{
    @EnvironmentObject var userdata:UserData
    var imgs2 = [
        "info",
        "news",
        "sport"
    ]
    var imgs = [
        "🏃‍♂️",
        "✹",
        "ℹ️"
    ]
    var texts = [
        "健身记录",
        "工会资讯",
        "个人中心"
    ]


    var body:some View{

        TabbedView{
            giftPage()
            .tabItemLabel(Text(self.texts[0]))
                .tag(0)
            newsList(news: self.userdata.newsDatas)
                .tabItemLabel(Text(self.texts[1]))
                .tag(1)
            infoPage(info: self.userdata.infoDatas)
                .tabItemLabel(Text(self.texts[2]))
                .tag(2)
        
        }
    }
}





/*

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
       mainpage().environmentObject(UserData())
    }
}
#endif
 */
