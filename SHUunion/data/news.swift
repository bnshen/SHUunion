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
    var title:String
    var abstract:String
    var content:String
    var author:String
    var date:String
}
    

