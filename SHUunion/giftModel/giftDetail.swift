//
//  giftDetail.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct giftDetail : View {
    @EnvironmentObject var userData: UserData
    @State var gift:gifts
    var giftIndex: Int {
       userData.giftsDatas.firstIndex(where: { $0.id == gift.id })!
    }
    @State var showAlert = false
    
    var body: some View {
        VStack{
            Text(gift.name).font(.title)
            //gift.image(forSize: 250)
            self.userData.giftImages[self.userData.giftsDatas[self.giftIndex]].map { giftimg in
                Image(uiImage: giftimg)
                    .resizable()
                    .frame(width: 250, height: 250)
                    .aspectRatio(contentMode: .fit)
            }
            List{
            
                Section(header:Text("简介")){
            Text(gift.description)
                .lineLimit(nil)
                
                }
                }.background(Color.white)
            
            
             Spacer()
            /*
             
             Button(action: {
                
             }, label: {
                Text("兑换礼品")
                .color(Color.white)
                    .frame(width: UIScreen.main.bounds.width-30,
                           height: 45)
             }
                )
            .background(Color.orange)
            .cornerRadius(10)
            */
            if self.userData.giftsDatas[giftIndex].available == true{
            if self.userData.giftsDatas[giftIndex].redeemed == false
             {
            Button(action: {
                self.showAlert = true
                print("Tap")
            }) {
                Text("兑换礼品")
                    .font(.system(size: 20,
                                  design: .rounded))
                    .color(Color.white)
                    .frame(width: UIScreen.main.bounds.width-30,
                           height: 45)
                }.presentation($showAlert, alert: {
                    Alert(title: Text("确定要兑换吗？"),
                          message: Text("兑换完成后请前往工会领取"),
                          primaryButton: .destructive(Text("确认")) {
                            self.userData.giftsDatas[self.giftIndex].redeemed = true
                            print("转出中...")
                            self.userData.get_gift(prize_id:self.userData.giftsDatas[self.giftIndex].id)
                        },
                          secondaryButton: .cancel())
                }).background(Color.orange)
                .cornerRadius(10)
            }
            else{
                Button(action: {
                    self.showAlert = true
                    print("Tap")
                }) {
                    Text("已兑换")
                        .font(.system(size: 20,
                                      design: .rounded)).fontWeight(.bold)
                        .color(Color.white)
                        .frame(width: UIScreen.main.bounds.width-30,
                               height: 45)
                    }.presentation($showAlert, alert: {
                        Alert(title: Text("已兑换"),
                              message: Text("请勿重复兑换"),
                              primaryButton: .destructive(Text("确认")) {
                                print("转出中...")
                                
                            },
                              secondaryButton: .cancel())
                    }).background(Color.orange)
                    .cornerRadius(10)
            }
        }
        }.padding().edgesIgnoringSafeArea(.top)
        
    }
    
    
 
}

/*

#if DEBUG
struct giftDetail_Previews : PreviewProvider {
    static var previews: some View {
        giftDetail(gift: giftsData[2])
        //ContentView2()
    }
}
#endif
 */
