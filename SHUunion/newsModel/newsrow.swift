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
    var body: some View {
            VStack{
                Text(_news.title).font(.headline)
                Text(_news.abstract)
                    .lineLimit(4)
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
