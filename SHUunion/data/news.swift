//
//  news.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct news:Hashable,Identifiable,Codable {
    var id: String
    var real_id:String
    var title:String
    var abstract:String
    var content:String
    var author:String
    var date:String
    var is_ticket:Bool
    var cnt:Int
    var icon_path:String
    var vedio_path:String
    var does_get:Bool
    var current:Int
}

struct ticketStat:Decodable{
    var status:String
    init(){
        self.status = ""
    }
}

