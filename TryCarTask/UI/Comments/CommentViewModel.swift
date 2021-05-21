//
//  CommentViewModel.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit
import Combine

class CommentViewModel: BaseViewModel {
    
    // MARK:- vars
    var commentsSubject = PassthroughSubject<[Comment],Error>()
    var internetError = Observable<String>()
    
    func fetchComments(with postId: Int) {
        if Connectivity.isConnectedToInternet {
            service.fetchComments(postId: postId) { result in
                do {
                    let comments = try result.get()
                    self.commentsSubject.send(comments)
                } catch {
                    self.commentsSubject.send(completion: .failure(error))
                }
            }
        } else {
            internetError.property = "There is no Internet Connection"
        }
    }
    
    func addPostToFavorite(postId: Int) {
        manager.updatePost(postId: postId)
    }
}
