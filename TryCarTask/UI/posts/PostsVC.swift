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
    
    private var posts = [Post]()

    override func setupView() {
        configureTableView()
        viewModel.fetchPosts()
    }
    
    private func configureTableView() {
        /// register cell
        
        /// delegate
        tableView.dataSource = handler
        tableView.delegate = handler
        /// action in cell
        handler.didTapPost = { [weak self] indexPath in
            self?.navigationController?.pushViewController(CommentsVC.create(with: 1), animated: true)
        }
    }
    
    override func observeViewModel() {
        subscriber = viewModel.postsSubject
            .sink(receiveCompletion: { resultCompetion in
                switch resultCompetion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            },receiveValue: { [weak self]  newPosts in
                self?.posts = newPosts
                self?.tableView.reloadData()
            })
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

