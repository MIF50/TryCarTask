//
//  Observable.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import Foundation

class Observable<T: Equatable> {
    
    private let thread : DispatchQueue
    var observe : ((T) -> ())?
    var property : T? {
        willSet(newValue) {
            if let newValue = newValue,  property != newValue {
                thread.async {
                    self.observe?(newValue)
                }
            }
        }
    }
    
    init(_ value: T? = nil, thread dispatcherThread: DispatchQueue = DispatchQueue.main) {
        self.thread = dispatcherThread
        self.property = value
    }
}
