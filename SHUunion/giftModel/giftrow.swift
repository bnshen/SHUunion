//
//  giftrow.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct giftrow : View {
    @State var gifts:gifts
    @EnvironmentObject var userdata:UserData
    var giftIndex: Int {
        userdata.giftsDatas.firstIndex(where: { $0.id == gifts.id })!
    }
    var body: some View {
        
        HStack {
            gifts.image(forSize: 50).renderingMode(.original)
            Text(verbatim: gifts.name).color(.primary).font(.title)
            Spacer()
            VStack(alignment: .trailing){
        Text("\(self.userdata.giftsDatas[giftIndex].stepNow)/\(self.userdata.giftsDatas[giftIndex].stepNeed)步").color(.primary).font(.subheadline)
                HStack{
                     Text("从\(gifts.year)年\(gifts.month)月\(gifts.day)日开始").font(.caption)
                    
                if self.userdata.giftsDatas[giftIndex].redeemed {
                    Text("已兑换").font(.caption).fontWeight(.bold).color(.green)
                }else if self.userdata.giftsDatas[giftIndex].available{
                        Text("未兑换").font(.caption).fontWeight(.bold).color(.orange)
                }else{
                    Text("未达条件").font(.caption).fontWeight(.bold).color(.red)
                }
                   
                }
            }
            }
        }
    }

/*

#if DEBUG
struct giftrow_Previews : PreviewProvider {
    static var previews: some View {
      //  giftrow(gifts:giftsData[0])
    }
}
#endif
 */
