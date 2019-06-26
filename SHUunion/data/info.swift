//
//  info.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//


import SwiftUI

struct info:Hashable,Identifiable,Codable {
    var id: String
    var name:String
    var region: String
    func image(forSize size: Int) -> Image {
        ImageStore.shared.image(name: name, size: size)
    }
    var anyStep:Int
    var today_step:Int?
    var week_step:Int?
    var month_step:Int?
    var total_step:Int?
    func steps_ready() -> Bool {
        return (self.today_step != nil) && (self.week_step != nil) && (self.month_step != nil) && (self.total_step != nil)
    }
    
    
}
