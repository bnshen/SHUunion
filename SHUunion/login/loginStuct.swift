//
//  loginStuct.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/24.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct loginStuct:Decodable {
    var status:loginStuctReceive
    func logined() -> Bool{
        return self.status.status == "200"
    }
    init(){
        self.status = loginStuctReceive()
    
    }
    func requestStatus() -> String {
        if self.status.status == "404"{
            return "用户名或密码错误"
        }
        return ""
        
    }
}


struct loginStuctReceive:Decodable{
    var status:String
    init(){
        self.status = ""
    }
}
