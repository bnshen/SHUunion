//
//  newsrow.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct newsrow : View {
    var _news:news
    @EnvironmentObject var userData: UserData
    var newsIndex: Int {
        userData.newsDatas.firstIndex(where: { $0.id == _news.id })!
    }
    var body: some View {
        VStack(alignment:.leading){
                Text(self.userData.newsDatas[self.newsIndex].title).font(.headline)
                Text(self.userData.newsDatas[self.newsIndex].abstract)
                    .lineLimit(nil)
                if self.userData.newsDatas[self.newsIndex].is_ticket == true{
                    HStack{
                        Text("票务信息").font(.caption).color(Color.red)
                        Text("当前票数\(self.userData.newsDatas[self.newsIndex].current!)/\(self.userData.newsDatas[self.newsIndex].cnt!)").font(.caption).color(Color.red).bold()
                    }
                }
            }
        }
        
}
#if DEBUG
struct newsrow_Previews : PreviewProvider {
    static var previews: some View {
        newsrow(_news:newsData[0])
    }
}
#endif
