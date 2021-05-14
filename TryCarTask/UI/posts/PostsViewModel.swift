//
//  PostsViewModel.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit
import Combine

class PostViewModel: BaseViewModel {
    
    // MARK:- vars
    var postsSubject = PassthroughSubject<[Post],Error>()
    var internetError = Observable<String>()
    var postsCached = Observable<[Post]>()
    var loading = Observable<Bool>()

    func fetchPosts() {
        loading.property = true
        if Connectivity.isConnectedToInternet {
            service.fetchPosts { result in
                self.loading.property = false
                switch result {
                case .success(let posts):
                    self.manager.cachePosts(posts: posts)
                    self.postsSubject.send(posts)
                case .failure(let error):
                    self.postsSubject.send(completion: .failure(error))
                }
            }
        } else {
            loading.property = false
            internetError.property = "There is No Internet Connection"
            postsCached.property = manager.getPosts()
        }
    }
}
