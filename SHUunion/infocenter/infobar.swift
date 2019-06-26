//
//  infobar.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct infobar : View {
    var info:info
    var body: some View {
        VStack{
            VStack{
                HStack {
                    CircleImage(image: info.image(forSize: 100))
                    
                    VStack(alignment: .leading) {
                        Text(info.name).font(.title)
                        Text(info.region).font(.subheadline)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    
                }
            }
            
            
        }.padding()
    }
}

#if DEBUG
struct infobar_Previews : PreviewProvider {
    static var previews: some View {
        infobar(info:infoData)
    }
}
#endif
