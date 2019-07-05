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
    func rankDisplay() -> String{
        switch self.rankType.rawValue {
        case "dayRank":
            return "每日排行"
        case "weekRank":
            return "每周排行"
        case "monthRank":
            return "每月排行"
        case "seasonRank":
            return "每季排行"
        default:
            return ""
        }
    }
 
    //var rankType:String
    var info:info
    var rankStatus:Int
}

struct rankReceive:Decodable {
    var items:[Rank]
}
