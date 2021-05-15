//
//  Debounce.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/15/21.
//

import UIKit

// MARK:- Debounce
class Debounce<T: Equatable> {
    
    private init() {}
    
    static func input(_ input: T,
                      comparedAgainst current: @escaping @autoclosure () -> (T),
                      perform: @escaping (T) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if input == current() { perform(input) }
        }
    }
}
