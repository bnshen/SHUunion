//
//  rankItem.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/21.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct rankItem : View {
    var rank:Rank
    var body: some View {
        VStack{
            VStack{
                HStack {
                    CircleImage(image: rank.info.image(forSize: 50))
                    
                    VStack(alignment: .leading) {
                        Text(rank.info.name).font(.title)
                        Text(rank.info.region).font(.subheadline)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    VStack {
                        Text("第 \(rank.rankStatus) 名").font(.subheadline)
                        Text("\(rank.info.anyStep) 步")
                            .font(.caption)
                    }
                }
            }
            Spacer()
            
            }
    }
}

#if DEBUG
struct rankItem_Previews : PreviewProvider {
    static var previews: some View {
        rankItem(rank:rankData[0])
    }
}
#endif
