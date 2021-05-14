//
//  Connectivity.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import Alamofire

// MARK:- Check Internet Connection
struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
