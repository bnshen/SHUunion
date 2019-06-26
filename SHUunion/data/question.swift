//
//  question.swift
//  SHUunion
//
//  Created by 沈博南 on 2019/6/26.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct question:Decodable,Identifiable{
    var id:String
    var send_id:String
    var receive_id:String
    var context:String
    var send_time:String
    var type:String
    init(){
        self.id = "1"
        self.send_id = "1"
        self.receive_id = "1"
        self.context = ""
        self.send_time = ""
        self.type = ""
    }
}
struct questionReceive:Decodable{
    var items:[question]
}
