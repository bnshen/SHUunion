//
//  newsDetail.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct newsDetail : View {
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
