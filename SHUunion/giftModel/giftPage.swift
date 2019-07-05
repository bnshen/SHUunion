//
//  giftPage.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct giftPage : View {
    @EnvironmentObject private var userdata:UserData
    @State var firstAppear:Bool = false
    var body:some View{
        NavigationView
            {
                VStack{
                    HStack{
                        Text("今日步数:\(userdata.today)").bold()
                        Spacer()
                    }.padding(.leading,20)
            List{
                 Section(header:Text("更新数据")){
                Button(
                    action: userdata.update,
                    label: { Text("更新数据")}
                    )
                }
                Section(header:Text("兑换礼品")){
                ForEach(userdata.giftsDatas){
                    gift in
                    NavigationButton(
                    destination: giftDetail(gift:gift)) {
                        giftrow(gifts: gift)
                    }
                }
                }
                 Section(header:Text("查看排名")){
                NavigationButton(destination: self.rankP){
                Image(systemName: "list.number")
                    Text("查看排名")
                }
                }
               
                    }

            }.navigationBarTitle(
                    Text("欢迎来到上海大学工会"), displayMode:.automatic)
                .background(Color.white)
            
                
                
            
    
        }
        .onAppear(perform: self.firstInit)
    }
    
    var rankP:some View{
        List{
            NavigationButton(
                destination: rankPage(ranks: self.userdata.rankDatas.filter{
                    $0.rankType.rawValue=="dayRank"
                })) {
                    Text("每日排名")
            }
            NavigationButton(
                destination: rankPage(ranks: self.userdata.rankDatas.filter{
                    $0.rankType.rawValue=="weekRank"
                })) {
                    Text("每周排名")
            }
            NavigationButton(
                destination: rankPage(ranks: self.userdata.rankDatas.filter{
                    $0.rankType.rawValue=="monthRank"
                })) {
                    Text("每月排名")
            }
        }.listStyle(.grouped)
    }
    
    func firstInit(){
        if self.firstAppear == false{
            userdata.steps.firstInit()
            userdata.search()
            userdata.get_rank()
            userdata.get_news()
            self.firstAppear = true
        }
    }
}



#if DEBUG
struct giftPage_Previews : PreviewProvider {
    static var previews: some View {
        giftPage().environmentObject(UserData())
    }
}
#endif

