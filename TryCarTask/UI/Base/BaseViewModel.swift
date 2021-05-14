//
//  BaseViewModel.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import Foundation

class BaseViewModel {
    
    let service: APIServices!
    let manager: PostManager
    
    init() {
        service = APIServices.shared
        manager = PostManager.shared
    }
}
