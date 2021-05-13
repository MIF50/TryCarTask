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
    
    func fetchPosts() {
        service.fetchPosts { result in
            switch result {
            case .success(let posts):
                self.postsSubject.send(posts)
            case .failure(let error):
                self.postsSubject.send(completion: .failure(error))
            }
        }
    }
}
