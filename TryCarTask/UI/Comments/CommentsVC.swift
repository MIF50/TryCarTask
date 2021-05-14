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
    private var postId  = 0
    
    override func setupView() {
        super.setupView()
        configureTableView()
        configureNavigationBar()
        viewModel.fetchComments(with: postId)
    }
    
    private func configureTableView() {
        tableView.contentInset = .init(top: 8, left: 0, bottom: 8, right: 0)
        /// register cell
        tableView.register(CommentTVCell.self)
        /// delegate
        tableView.dataSource = handler
        tableView.delegate = handler
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapFavorite))
    }
    
    @objc private func didTapFavorite() {
        viewModel.addPostToFavorite(postId: postId)
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
            self?.handler.indexData = comments
            self?.tableView.reloadData()
        })
        
        viewModel.internetError.observe = { [weak self] message in
            self?.showAlert(title: "Opps!", message: message)
        }
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
