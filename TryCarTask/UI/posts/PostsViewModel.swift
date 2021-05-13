//
//  PostsViewModel.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit
import Combine

class PostViewModel: BaseViewModel {
    
    var postsSubject = PassthroughSubject<[Post],Error>()
    var internetError = Observable<String>()

    func fetchPosts() {
        if Connectivity.isConnectedToInternet {
            service.fetchPosts { result in
                switch result {
                case .success(let posts):
                    self.postsSubject.send(posts)
                case .failure(let error):
                    self.postsSubject.send(completion: .failure(error))
                }
            }
        } else {
            internetError.property = "There is No Internet Connection"
        }
    }
}
