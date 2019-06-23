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

    func update() {
        self.getStepCounts_today(healthStore: self.steps.healthStore)
        (0...self.giftsDatas.count-1).forEach{
            item in
            self.getStepCounts_from_date(year: self.giftsDatas[item].year, month: self.giftsDatas[item].month,day: self.giftsDatas[item].day,healthStore: self.steps.healthStore,index:item)
        }
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
        var newDate1 = calendar.date(from: components)
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

        var urlComponents = URLComponents(string: "http://192.168.1.3:8000/gift")!
     //   urlComponents.queryItems = [
     //       URLQueryItem(name: "q", value: name)
     //   ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("searching..")
        searchCancellable = URLSession.shared.send(request: request)
            .decode(type:giftsResponse.self, decoder: JSONDecoder())
            .map { $0.items }
            .replaceError(with: [])
            .assign(to: \.giftsDatas, on: self)
    }

 
    
}
