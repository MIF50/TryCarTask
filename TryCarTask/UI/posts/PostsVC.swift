//
//  ViewController.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit

class PostsVC: BaseVC {
    
    // MARK:- Outlet
    @IBOutlet var tableView: UITableView!
    
    // MARK:- ViewModel
    fileprivate let viewModel = PostViewModel()
    
    // MARK:- Handler
    fileprivate let handler = PostsHandler()
    
    override func setupView() {
        configureTableView()
        viewModel.fetchPosts()
    }
    
    private func configureTableView() {
        tableView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        /// register cell
        tableView.register(PostTVCell.self)
        /// delegate
        tableView.dataSource = handler
        tableView.delegate = handler
        /// action in cell
        handler.didTapPost = { [weak self] _ , postId in
            self?.navigationController?.pushViewController(CommentsVC.create(with: postId), animated: true)
        }
    }
    
    override func observeViewModel() {
        /// posts from api
        subscriber = viewModel.postsSubject
            .sink(receiveCompletion: { resultCompetion in
                switch resultCompetion {
                case .failure(let error):
                    print("Error: \(error)")
                    self.showEmptyStateView(with: error.localizedDescription, in: self.view)
                case .finished:
                    break
                }
            },receiveValue: { [weak self]  posts in
                self?.refreshTablView(with: posts)
            })
        /// caching posts
        viewModel.postsCached.observe = {[weak self]  posts in
            self?.refreshTablView(with: posts)
        }
        /// error internet
        viewModel.internetError.observe = { [weak self] message in
            self?.showAlert(title: "Opps!", message: message)
        }
        /// loading
        viewModel.loading.observe = { [weak self] isloading in
            if  isloading {
                self?.showLoadingView()
            } else {
                self?.hideLoadingView()
            }
        }
    }
    
    private func refreshTablView(with posts: [Post]) {
        handler.indexData = posts
        tableView.reloadData()
    }
}

// MARK:- CreatePosstVC
extension PostsVC {
    
    static func create()->UIViewController {
        let vc = PostsVC.instantiate(name: .Main)
        vc.navigationItem.title = "Post"
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.tabBarItem = UITabBarItem(title: "Post", image: UIImage(systemName: "list.bullet.indent"), tag: 0)
        return UINavigationController(rootViewController: vc)
    }
}

