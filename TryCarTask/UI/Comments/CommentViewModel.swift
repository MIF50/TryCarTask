//
//  CommentViewModel.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit
import Combine

class CommentViewModel: BaseViewModel {
    
    var commentsSubject = PassthroughSubject<[Comment],Error>()
    
    func fetchComments(with postId: Int) {
        service.fetchComments(postId: postId) { result in
            switch result {
            case .success(let comments):
                self.commentsSubject.send(comments)
            case .failure(let error):
                self.commentsSubject.send(completion: .failure(error))
            }
        }
    }
}
