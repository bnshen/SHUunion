//
//  Rank.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/21.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct Rank:Identifiable,Hashable,Decodable{
    var id:String
    var rankType:RankType
    enum RankType: String, CaseIterable, Codable, Hashable {
        case dayRank = "dayRank"
        case weekRank = "weekRank"
        case monthRank = "monthRank"
        case seasonRank = "seasonRank"
    }
 
    //var rankType:String
    var info:info
    var rankStatus:Int
}

struct rankReceive:Decodable {
    var items:[Rank]
}
