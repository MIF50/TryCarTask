//
//  FavoriteViewModel.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit
import Combine

class FavoriteViewModel: BaseViewModel {
    
    var posts = Observable<[Post]>()
    
    func getFavorites() {
        posts.property = PostManager.shared.getFavorite()
    }
}
