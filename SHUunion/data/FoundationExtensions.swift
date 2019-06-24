//
//  FoundationExtensions.swift
//  SHUunion
//
//  Created by shenbonan_IMAC on 2019/6/22.
//  Copyright © 2019 shenbonan_IMAC. All rights reserved.
//
import SwiftUI
import Combine

enum RequestError: Error {
    case request(code: Int, error: Error?)
    case unknown
}

extension URLSession {
    func send(request: URLRequest) -> AnyPublisher<Data, RequestError> {
        AnyPublisher { subscriber in
            let task = self.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    let httpReponse = response as? HTTPURLResponse
                    if let data = data, let httpReponse = httpReponse, 200..<300 ~= httpReponse.statusCode {
                        _ = subscriber.receive(data)
                        subscriber.receive(completion: .finished)
                    }
                    else if let httpReponse = httpReponse {
                        subscriber.receive(completion: .failure(.request(code: httpReponse.statusCode, error: error)))
                    }
                    else {
                        subscriber.receive(completion: .failure(.unknown))
                    }
                    
                }
               
                do {
                    let r = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(r)
                } catch {
                    print("无法连接到服务器")
                    return
                }
                
            }
            
            subscriber.receive(subscription: AnySubscription(task.cancel))
            task.resume()
        }
    }
}

extension JSONDecoder: TopLevelDecoder {}
