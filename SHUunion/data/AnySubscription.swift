//
//  AnySubscription.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/22.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//

import Combine

final class AnySubscription: Subscription {
    private let cancellable: Cancellable
    
    init(_ cancel: @escaping () -> Void) {
        cancellable = AnyCancellable(cancel)
    }
    
    func request(_ demand: Subscribers.Demand) {}
    
    func cancel() {
        cancellable.cancel()
    }
}
