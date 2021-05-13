//
//  CommentsVC.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit

class CommentsVC: BaseVC {
    
    // MARK:- Outlet
    @IBOutlet var tableView: UITableView!
    
    // MARK:- ViewModel
    private let viewModel = CommentViewModel()
    
    // MARK:- Handler
    private let handler = CommentHandler()
    
    // MARK:- vars
    private var comments = [Comment]()
    private var postId  = 0
    
    override func setupView() {
        super.setupView()
        configureTableView()
        
    }
    
    private func configureTableView() {
        /// register cell
        /// delegate
        tableView.dataSource = handler
        tableView.delegate = handler
    }
    
    override func observeViewModel() {
        super.observeViewModel()
        subscriber = viewModel.commentsSubject.sink(receiveCompletion: { resultCompletion in
            switch resultCompletion {
            case .failure(let error):
            print("error: \(error)")
            case .finished:
                break
            }
        }, receiveValue: {[weak self] comments in
            self?.comments = comments
            self?.tableView.reloadData()
        })
        
    }
}

// MARK:- CreateCommentsVC
extension CommentsVC {
    
    static func create(with postId: Int) -> UIViewController {
        let vc = CommentsVC.instantiate(name: .Main)
        vc.title = "DetailsPost"
        vc.postId = postId
        return vc
    }
}
