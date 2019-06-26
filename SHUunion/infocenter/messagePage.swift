//
//  messagePage.swift
//  SHUunion
//
//  Created by 沈博南 on 2019/6/26.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct messagePage : View {
    @EnvironmentObject var userdata:UserData
    var body: some View {
        NavigationView{
            List{
                ForEach(self.userdata.message){
                    mesg in
                    VStack(alignment:.leading){
                        if mesg.receive_id == self.userdata.infoDatas.id{
                        Text("在\(mesg.send_time)收到的消息")
                        }
                        else{
                            Text("在\(mesg.send_time)发送的消息")
                        }
                        Text("\(mesg.context)").lineLimit(nil)
                    }
                    
                }
            }.navigationBarTitle(Text("问题咨询"))
            .listStyle(.grouped)
            
            }.onAppear(perform:self.update).edgesIgnoringSafeArea(.top)
        
    }
    
    func update() {
        self.userdata.get_ticket()
    }
    
}


