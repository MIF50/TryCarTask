//
//  FavoriteVC.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit

class FavoriteVC: BaseVC {
    
    // MARK:- Outlet
    @IBOutlet var tableView: UITableView!
    
    // MARK:- ViewModel
    fileprivate let viewModel = FavoriteViewModel()
    
    // MARK:- handler
    fileprivate let handler = PostsHandler()
    
    override func setupView() {
        super.setupView()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        viewModel.getFavorites()
    }
    
    private func configureTableView() {
        /// regsister
        tableView.register(PostTVCell.create(), forCellReuseIdentifier: "PostTVCell")
        /// delegate
        tableView.dataSource = handler
        tableView.delegate = handler
        // action
        handler.didTapPost = {[weak self] indexPath, postId in
            self?.navigationController?.pushViewController(CommentsVC.create(with: postId), animated: true)
        }
    }
    
    override func observeViewModel() {
        super.observeViewModel()
        viewModel.posts.observe = { [weak self] posts in
            self?.handler.indexData = posts
            self?.tableView.reloadData()
        }
    }
}

// MARK:- CreateFavoriteVC
extension FavoriteVC {
    
    static func create()-> UIViewController {
        let vc = FavoriteVC.instantiate(name: .Main)
        vc.navigationItem.title = "Favorite"
        vc.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star.circle.fill"), tag: 1)
        return UINavigationController(rootViewController: vc)
    }
}
