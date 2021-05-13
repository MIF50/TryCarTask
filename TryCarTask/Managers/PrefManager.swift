//
//  PrefManager.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit
import Alamofire

final class PrefManager {
    
    static let shared = PrefManager()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    /// To get headers
    /// - Returns: HTTPHeaders
    func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            .accept("application/json")
        ]
        return headers
    }
}

