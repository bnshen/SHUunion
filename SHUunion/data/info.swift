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
    
}
