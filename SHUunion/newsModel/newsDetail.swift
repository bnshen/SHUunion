//
//  newsDetail.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct newsDetail : View {
    @State var showAlert:Bool = false
    @EnvironmentObject var userData: UserData
    var newsIndex: Int {
        userData.newsDatas.firstIndex(where: { $0.id == news.id })!
    }
    var news:news
    var body: some View {
        VStack(alignment: .leading){
            Text(news.title).font(.largeTitle).fontWeight(.semibold).lineLimit(nil)
            HStack {
                Text(news.date)
                Spacer()
                Text(news.author)
            }.padding()
            
            Text(news.content).lineLimit(nil)
            
            if self.userData.newsDatas[self.newsIndex].is_ticket{
            if self.userData.newsDatas[self.newsIndex].does_get == false{
            Spacer()
            Button(action: {
                self.showAlert = true
            }) {
                Text("立即抢票")
                    .font(.system(size: 20,
                                  design: .rounded)).fontWeight(.bold)
                    .color(Color.white)
                    .frame(width: UIScreen.main.bounds.width-30,
                           height: 45)
                }.presentation($showAlert, alert: {
                    Alert(title: Text("锁票中"),
                          message: Text("请耐心等待"),
                          primaryButton: .destructive(Text("确认")) {
                            print("转出中...")
                            
                        },
                          secondaryButton: .cancel())
                }).background(Color.orange)
                .cornerRadius(10)
            }
            else{
                Spacer()
                Button(action: {
                    self.showAlert = true
                }) {
                    Text("立即抢票")
                        .font(.system(size: 20,
                                      design: .rounded)).fontWeight(.bold)
                        .color(Color.white)
                        .frame(width: UIScreen.main.bounds.width-30,
                               height: 45)
                    }.presentation($showAlert, alert: {
                        Alert(title: Text("恭喜你"),
                              message: Text("已抢到票"),
                              primaryButton: .destructive(Text("确认")) {
                                print("转出中...")
                                
                            },
                              secondaryButton: .cancel())
                    }).background(Color.orange)
                    .cornerRadius(10)
            
            }
            }
        }.padding()
    }
}

#if DEBUG
struct newsDetail_Previews : PreviewProvider {
    static var previews: some View {
        newsDetail(news: newsData[0])
    }
}
#endif
