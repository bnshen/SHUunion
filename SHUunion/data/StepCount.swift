//
//  StepCount.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/20.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import SwiftUI
import HealthKit

class stepCount{
    var today_step:Int
    var week_step:Int
    var month_step:Int
    var season_step:Int
    var total_step:Int
    let healthStore = HKHealthStore()
    func firstInit() -> () {
        if HKHealthStore.isHealthDataAvailable() {
            print("available")
            let allTypes = Set([HKObjectType.workoutType(),
                                //HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                //HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
                                //HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                                //HKObjectType.quantityType(forIdentifier: .heartRate)!])
                HKObjectType.quantityType(forIdentifier: .stepCount)!])
            
            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if !success {
                    print("fail")
                }
                else{
                    
                }
            }
        }
    }
    init() {
        self.today_step = 0
        self.week_step = 0
        self.month_step = 0
        self.season_step = 0
        self.total_step = 0
    }
    
    func getStepCounts_today() {
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
            self.today_step = Int(resultCount)
            DispatchQueue.main.async{
               
            }
         
        }
        
        healthStore.execute(query)
        
    }
    func getStepCounts_from_date(year:Int,month:Int,day:Int) {
        
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
            self.total_step = Int(resultCount)
            print("test_total:\(resultCount)")
            
            
        }
        
        healthStore.execute(query)
    }
}
