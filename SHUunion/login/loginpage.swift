//
//  loginpage.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/24.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI

struct loginpage : View {
    @State var username:String = ""
    @State var password:String = ""
    @EnvironmentObject var userdata:UserData
    var usernameHint = Text("一卡通账号")
    var passwordHint = Text("一卡通密码")
    var body: some View {
        VStack {
            Image("appIcon")
                .resizable()
                .frame(width: 200, height: 200)
                //.clipShape(Circle())
                .padding(.bottom)
                .padding(.top,30)
            Text("上海大学工会").font(.title).padding(.bottom,50)
            //  Text("登陆")
            //  .font(.title)
            //  .bold()
            //  .foregroundColor(.primary)
            
            Text("使用统一身份认证登陆")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            
            
            VStack{
                TextField(self.$username,placeholder: self.usernameHint)
                    .padding()
                    
                    .border(Color.gray, width: 3, cornerRadius: 100)
                    .padding(.horizontal)
                
                
                SecureField(self.$password,placeholder: self.passwordHint)
                    .padding()
                    
                    .border(Color.gray, width: 3, cornerRadius: 100)
                    .padding(.horizontal)
                }.padding(.horizontal, 50.0)
            
            
            
            // This will only get rendered when the state changes to subscribed.
            
            
            Button(action: {
                print("loginButton")
                self.userdata.login(username: self.username,password: self.password)
                
            }) {
                Text("登陆")
                    .foregroundColor(.white)
                    .animation(.none)
                    .padding(10)
                    .frame(width: 200)
                    .cornerRadius(20)
                    .border(Color.blue, width: 1, cornerRadius: 20)
                    .background(Color.blue)
                    .cornerRadius(20)
                
                }
                .padding(.top, 20)
            
            
            Text(self.userdata.loginDatas.requestStatus())
            Spacer()
            
            Text("Copyright 2019, @夏季学期 app开发")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 60)
        }
        
    }
  
}

#if DEBUG
struct loginpage_Previews : PreviewProvider {
    static var previews: some View {
        loginpage()
    }
}
#endif
