//
//  Userdata.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import Combine
import SwiftUI
import HealthKit
import SQLite

final class UserData: BindableObject {
    let didChange = PassthroughSubject<UserData, Never>()
    static let shared = UserData()
    var showFavoritesOnly = false {
        didSet {
            didChange.send(self)
        }
    }
    
    var infoDatas = infoData {
        didSet {
            didChange.send(self)
        }
    }
    var newsDatas = newsData {
        didSet {
            didChange.send(self)
        }
    }
    var giftsDatas = [gifts]() {
        didSet {
            didChange.send(self)
        }
    }
    
    
    var steps = steper {
        didSet {
            didChange.send(self)
        }
    }
    
    var today = steper.today_step{
        didSet {
            didChange.send(self)
        }
    }
    var total = steper.total_step{
        didSet {
            didChange.send(self)
        }
    }
    var message = [question](){
        didSet{
            didChange.send(self)
        }
    }
    let baseUrl = URL(string:"http://127.0.0.1:8000")!

    
    func update() {
        if self.giftsDatas.count == 0{
            return
        }
        self.getStepCounts_today(healthStore: self.steps.healthStore)
        (0...self.giftsDatas.count-1).forEach{
            item in
            self.getStepCounts_from_date(year: self.giftsDatas[item].year, month: self.giftsDatas[item].month,day: self.giftsDatas[item].day,healthStore: self.steps.healthStore,index:item)
        }
        self.getStepCounts_all(healthStore: self.steps.healthStore)
    }
    
    var rankDatas = rankData{
        didSet {
            didChange.send(self)
        }
    }
    func getStepCounts_today(healthStore:HKHealthStore) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                print("Failed to fetch steps rate")
                return
            }
            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.count())
            }
            print(resultCount)
            DispatchQueue.main.async{
                self.today = Int(resultCount)
            }
            
        }
        
        healthStore.execute(query)
        
    }
    
    func getStepCounts_from_date(year:Int,month:Int,day:Int,healthStore:HKHealthStore,index:Int) {
        
        var components = DateComponents()
        components.year = year
        components.day = day
        components.month = month
        components.timeZone = TimeZone(abbreviation: "CCT")
        let calendar = Calendar.current
        let newDate1 = calendar.date(from: components)
        print("newdate:\(newDate1)")
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let _startOfDay = Calendar.current.startOfDay(for: now)
        let startOfDay = Calendar.current.date(byAdding: .day, value: -1, to: _startOfDay)
        print(_startOfDay)
        let predicate = HKQuery.predicateForSamples(withStart: newDate1, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                print("Failed to fetch steps rate")
                return
            }
            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.count())
            }
            print("test_total:\(resultCount)")
            DispatchQueue.main.async{
                self.giftsDatas[index].stepNow = Int(resultCount)
                if Int(resultCount) >= self.giftsDatas[index].stepNeed{
                      self.giftsDatas[index].available = true
                }
                
            }
            
        }
        
        healthStore.execute(query)
    }
    
    
    private var searchCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        searchCancellable?.cancel()
    }
    
    func search() {

        let endUrl = "gift"
        let queryURL = self.baseUrl.appendingPathComponent(endUrl)
        var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
     //   urlComponents.queryItems = [
     //       URLQueryItem(name: "q", value: name)
     //   ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("searching..")
        searchCancellable = URLSession.shared.send(request: request)
            .decode(type:giftsResponse.self, decoder: JSONDecoder())
            .map { $0.items }
            .replaceError(with: [])
            .assign(to: \.giftsDatas, on: self)
    }
    
    var loginDatas = loginStuct(){
        didSet {
            didChange.send(self)
        }
    }
   
    func login(username:String,password:String) {
        
        
        let endUrl = "login"
        let queryURL = self.baseUrl.appendingPathComponent(endUrl)
        var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        //   urlComponents.queryItems = [
        //       URLQueryItem(name: "q", value: name)
        //   ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        
        let postData = ["username":username,"password":password]
        let postString = postData.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        searchCancellable = URLSession.shared.send(request: request)
            .decode(type:loginStuctReceive.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with:loginStuctReceive())
            .assign(to: \.loginDatas.status , on: self)
    }
    
    func get_ticket(){
        
        let endUrl = "message"
        let queryURL = self.baseUrl.appendingPathComponent(endUrl)
        var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        //   urlComponents.queryItems = [
        //       URLQueryItem(name: "q", value: name)
        //   ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("searching..")
        searchCancellable = URLSession.shared.send(request: request)
            .decode(type:questionReceive.self, decoder: JSONDecoder())
            .map { $0.items }
            .replaceError(with: [])
            .assign(to: \.message, on: self)
    }
    
    
    func get_gift(prize_id:String){
        var giftIndex: Int {
            self.giftsDatas.firstIndex(where: { $0.id == prize_id })!
        }
        let endUrl = "gift"
        let queryURL = self.baseUrl.appendingPathComponent(endUrl)
        var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        //   urlComponents.queryItems = [
        //       URLQueryItem(name: "q", value: name)
        //   ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        
        let postData = ["user_id":self.infoDatas.id,"prize_id":prize_id]
        let postString = postData.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
       // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            guard error == nil else {
                return
            }
            do {
                let object = try decoder.decode(PostStat.self, from: data)
                DispatchQueue.main.async {
                    self.giftsDatas[giftIndex].status = object.status
                }
                print(object.status)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    func getStepCounts_all(healthStore:HKHealthStore) {
        var components = DateComponents()
        let days = [0,-7,-30,-365]
        
        for day in days{
         
            let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            let now = Date()
            let _start = Calendar.current.startOfDay(for: now)
            let start = Calendar.current.date(byAdding: .day, value: day, to: _start)
            let predicate = HKQuery.predicateForSamples(withStart: start, end: now, options: .strictStartDate)
            
            let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
                var resultCount = 0.0
                guard let result = result else {
                    print("Failed to fetch steps rate")
                    return
                }
                if let sum = result.sumQuantity() {
                    resultCount = sum.doubleValue(for: HKUnit.count())
                }
                
                print("days:\(day) getStepCounts_all_test_total:\(resultCount)")
                DispatchQueue.main.async{
                        if day == 0{
                            self.infoDatas.today_step = Int(resultCount)
                        }
                        if day == -7{
                            self.infoDatas.week_step = Int(resultCount)
                        }
                        if day == -30{
                            self.infoDatas.month_step = Int(resultCount)
                        }
                        if day == -365{
                            self.infoDatas.total_step = Int(resultCount)
                        }
                        if self.infoDatas.steps_ready(){
                            self.postSteps()
                        }
                
                    
                    }
                
            }
            healthStore.execute(query)
        }
        
    }
    
    func postSteps() {

        let endUrl = "rank"
        let queryURL = self.baseUrl.appendingPathComponent(endUrl)
        var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        
        let postData = [
            "today_step":self.infoDatas.today_step,
            "week_step":self.infoDatas.week_step,
            "month_step":self.infoDatas.month_step,
            "total_step":self.infoDatas.total_step,
        ]
        let postString = postData.compactMap({ (key, value) -> String in
            return "\(key)=\(String(value!))"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            guard error == nil else {
                return
            }
            do {
                let object = try decoder.decode(PostStat.self, from: data)
                DispatchQueue.main.async {
                   // self.giftsDatas[giftIndex].status = object.status
                }
                print(object.status)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    func get_rank(){
        let endUrl = "rank"
        let queryURL = self.baseUrl.appendingPathComponent(endUrl)
        var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        //   urlComponents.queryItems = [
        //       URLQueryItem(name: "q", value: name)
        //   ]
    
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("get ranking..")
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            guard error == nil else {
                return
            }
            do {
                let object = try decoder.decode(rankReceive.self, from: data)
                DispatchQueue.main.async {
                    self.rankDatas = object.items
                }
              //  print(object.items)
            } catch let error {
                print(error)
            }
        }
        task.resume()
     
    }
    
    func get_news(){
        let endUrl = "news"
        let queryURL = self.baseUrl.appendingPathComponent(endUrl)
        var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        //   urlComponents.queryItems = [
        //       URLQueryItem(name: "q", value: name)
        //   ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("get ranking..")
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            guard error == nil else {
                return
            }
            do {
                let object = try decoder.decode(ticketStat.self, from: data)
                DispatchQueue.main.async {
                    self.newsDatas = object.items
                }
                //  print(object.items)
            } catch let error {
                print(error)
            }
        }
        task.resume()
        
    }
    
    func post_tickets(id:String) {
        print("posting tickets")
        let endUrl = "news"
        let queryURL = self.baseUrl.appendingPathComponent(endUrl)
        var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        var newsIndex: Int {
            self.newsDatas.firstIndex(where: { $0.id == id })!
        }
        let postData = [
            "user_id":self.infoDatas.id,
            "ticket_id":self.newsDatas[newsIndex].real_id
        ]
        let postString = postData.compactMap({ (key, value) -> String in
            return "\(key)=\(String(value))"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("qweq", forHTTPHeaderField: "token")
        // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            guard error == nil else {
                return
            }
            do {
                let object = try decoder.decode(PostStat.self, from: data)
                
                DispatchQueue.main.async {
                    if object.status == "200"{
                        self.newsDatas[newsIndex].does_get = true
                    }
                }
                print(object.status)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    var locals = localS()

    func postMessage(id:String,content:String){
        let endUrl = "message"
        let queryURL = self.baseUrl.appendingPathComponent(endUrl)
        var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        
        let postData = [
            "user_id":id,
            "type":"",
            "content":content
        ]
        let postString = postData.compactMap({ (key, value) -> String in
            return "\(key)=\(String(value))"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            guard error == nil else {
                return
            }
            do {
                let object = try decoder.decode(PostStat.self, from: data)
                DispatchQueue.main.async {
                    // self.giftsDatas[giftIndex].status = object.status
                }
                print(object.status)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    private(set) var giftImages = [gifts: UIImage]() {
        didSet { didChange.send(self) }
    }
    
    func get_giftImages(for gift: gifts){
        guard case .none = self.giftImages[gift] else {
            return
        }
        let endUrl = "download/\(gift.img_url!)"
        let queryURL = self.baseUrl.appendingPathComponent(endUrl)
        var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        print(urlComponents)
        let request = URLRequest(url: urlComponents.url!)
        _ = URLSession.shared.send(request: request)
            .map { UIImage(data: $0) }
            .replaceError(with: nil)
            .sink(receiveValue: { [weak self] image in
                self?.giftImages[gift] = image
            })
    }
    
}
