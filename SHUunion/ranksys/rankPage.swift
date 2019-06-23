//
//  rankPage.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/21.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct rankPage : View {
    var ranks:[Rank]
    var body: some View {
        rankList(ranks: ranks).edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct rankPage_Previews : PreviewProvider {
    static var previews: some View {
        rankPage(ranks:rankData.filter({$0.rankType.rawValue == "dayRank"}))
    }
}
#endif
