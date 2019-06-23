//
//  rankList.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/21.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct rankList : View {
    var ranks:[Rank]
    var body: some View {
        NavigationView{
            List{
                ForEach(ranks){
                    rank in
                    rankItem(rank: rank)
                }
            }
    .navigationBarTitle(Text("\(ranks[0].rankType.rawValue)"),displayMode: .large)
        }
        
    }
}

#if DEBUG
struct rankList_Previews : PreviewProvider {
    static var previews: some View {
        rankList(ranks:rankData.filter({$0.rankType.rawValue == "dayRank"}))
    }
}
#endif
