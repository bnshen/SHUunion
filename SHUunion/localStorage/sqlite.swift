//
//  sqlite.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/26.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//
import SQLite
import Foundation
struct localS {
    func save(user_id:String,token:String)->Bool {
        var res:Bool=false
        do{
            let path = NSSearchPathForDirectoriesInDomains( .documentDirectory, .userDomainMask, true).first!
            print(path)
            let db = try Connection("\(path)/data.db")
            let loginTable = Table("login")
            let id = Expression<String>("id")
            let token = Expression<String>("token")
            //try db.run(loginTable.create { t in
            //    t.column(id, primaryKey: true)
            //    t.column(token)
            //})
            let user = loginTable.filter(id == "user_id")
            try db.run(user.delete())
            // DELETE FROM "users" WHERE ("id" = 1)
            let insert = loginTable.insert(id <- user_id, token <- token)
            //let rowid = try db.run(insert)
            // INSERT INTO "users" ("name", "email") VALUES ('Alice', 'alice@mac.com')
            
            for d in try db.prepare(loginTable) {
            print("id: \(d[id]), token: \(d[token])")
            // id: 1, name: Optional("Alice"), email: alice@mac.com
                res =  true
            }
            }
            catch let err{
            print(err)
                res = false
        }
        return res
    }
    func read(user_id:String)->String {
        var res:String=""
        do{
            let path = NSSearchPathForDirectoriesInDomains( .documentDirectory, .userDomainMask, true).first!
            print(path)
            let db = try Connection("\(path)/data.db")
            let loginTable = Table("login")
            let id = Expression<String>("id")
            let token = Expression<String>("token")
            //try db.run(loginTable.create { t in
            //    t.column(id, primaryKey: true)
            //    t.column(token)
            //})
            //let user = loginTable.filter(id == "user_id")
            //try db.run(user.delete())
            // DELETE FROM "users" WHERE ("id" = 1)
            //let insert = loginTable.insert(id <- user_id, token <- token)
            //let rowid = try db.run(insert)
            // INSERT INTO "users" ("name", "email") VALUES ('Alice', 'alice@mac.com')
            
            for d in try db.prepare(loginTable) {
                print("id: \(d[id]), token: \(d[token])")
                // id: 1, name: Optional("Alice"), email: alice@mac.com
                if d[id] == user_id{
                    res = d[token]
                }
                
            }
        }
        catch let err{
            print(err)
     
        }
        return res
    }
    init() {
        
    }
    
}
