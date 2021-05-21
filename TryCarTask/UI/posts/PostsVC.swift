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
    @IBOutlet var searchView: SearchView!
    
    // MARK:- ViewModel
    fileprivate let viewModel = PostViewModel()
    
    // MARK:- Handler
    fileprivate let handler = PostsHandler()
    
    override func setupView() {
        configureSearchView()
        configureTableView()
        viewModel.fetchPosts()
    }
    
    private func configureSearchView() {
        searchView.setup(placeholder: "Search", delegate: self)
    }
    
    private func configureTableView() {
        tableView.contentInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        handler.setup(tableView: tableView)
        /// Action in cell
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
        viewModel.liveDataPosts.observe = {[weak self]  posts in
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
        /// loading search
        viewModel.loadingSearch.observe = {[weak self] isLoading in
            self?.searchView.isLoading = isLoading
        }
        
        viewModel.postState.observe = { state in
            switch state  {
            case .loading:
                print("is loading state")
            case .loaded:
                print("is loaded state")
            case .success(let posts):
                print("get posts state \(posts.count)")
            case .failure(let error):
                print("error state \(error.localizedDescription)")
            }
        }
    }
    
    private func refreshTablView(with posts: [Post]) {
        handler.indexData = posts
        self.tableView.layer.add(easeInEaseOutAnimationTableView(), forKey: "UITableViewReloadDataAnimationKey")
        self.tableView.reloadData()
    }
    
    // MARK:- Animation EaseInEaseOut insert row In TableView
    private func easeInEaseOutAnimationTableView()->CATransition {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.fillMode = CAMediaTimingFillMode.forwards
        transition.duration = 0.5
        transition.subtype = CATransitionSubtype.fromTop
        return transition
    }
}

// MARK:- SearchViewDelegate
extension PostsVC : SearchViewDelegate {
    
    func onSearchWithDelay(text: String) {
        viewModel.search(query: text)
    }
    
    func onSearchCleared() {
        viewModel.onSearchCleared()
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

