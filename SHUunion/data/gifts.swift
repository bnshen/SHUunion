//
//  gifts.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI
import HealthKit

struct gifts:Identifiable,Hashable,Decodable {
    var id: String
    var name:String
    var description:String
    func image(forSize size: Int) -> Image {
        ImageStore.shared.image(name: name, size: size)
    }
    var redeemed:Bool
    var available:Bool
    var year:Int
    var month:Int
    var day:Int
    var stepNeed:Int
    var stepNow:Int
    func progress()-> Float{
        return Float(self.stepNow)/Float(self.stepNeed)
        
    }
}

struct giftsResponse: Decodable {
    var items: [gifts]
}
