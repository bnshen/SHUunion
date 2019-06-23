//
//  newsList.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct newsList : View {
    
    var news:[news]
    var body: some View {
        NavigationView{
            List{
                ForEach(news){
                    new in
                    NavigationButton(destination: newsDetail(news:new))
                    {newsrow(_news: new)}
                }
            }.navigationBarTitle(Text("最新资讯"), displayMode: .large)
                .background(Color.white)
                .listStyle(.grouped)
        }
    }
}

#if DEBUG
struct newsList_Previews : PreviewProvider {
    static var previews: some View {
        newsList(news:newsData)
    }
}
#endif
