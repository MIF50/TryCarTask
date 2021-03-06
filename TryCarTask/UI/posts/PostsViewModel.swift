//
//  PostsViewModel.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit
import Combine

enum PostState: Equatable {
    static func == (lhs: PostState, rhs: PostState) -> Bool {
        return true
    }
    
    case loading
    case loaded
    case failure(error: Error)
    case success(posts:[Post])
}

class PostViewModel: BaseViewModel {
    
    // MARK:- vars
    var postsSubject = PassthroughSubject<[Post],Error>()
    var internetError = Observable<String>()
    var liveDataPosts = Observable<[Post]>()
    var loading = Observable<Bool>()
    var loadingSearch = Observable<Bool>()
    
    private var posts = [Post]()
    private var filterPosts = [Post]()
    
    var postState = Observable<PostState>()

    func fetchPosts() {
        loading.property = true
        postState.property = .loading
        if Connectivity.isConnectedToInternet {
            service.fetchPosts { result in
                self.loading.property = false
                self.postState.property = .loaded
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.manager.cachePosts(posts: posts)
                    self.postsSubject.send(posts)
                    self.postState.property = .success(posts: posts)
                case .failure(let error):
                    self.postsSubject.send(completion: .failure(error))
                    self.postState.property = .failure(error: error)
                }
            }
        } else {
            loading.property = false
            internetError.property = "There is No Internet Connection"
            liveDataPosts.property = manager.getPosts()
        }
    }
    
    func search(query: String) {
        if query.isEmpty {
            print("query is empty")
            onSearchCleared()
            return
        }
        
        loadingSearch.property = true
        filterPosts = posts.filter {
            $0.title.contains(query)
        }
        /// fake delay to show loading search 
        delay(bySeconds: 2) {
            self.loadingSearch.property = false
            self.liveDataPosts.property = self.filterPosts
        }
    }
    
    func onSearchCleared() {
        liveDataPosts.property = posts
    }
}
