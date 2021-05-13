//
//  APIServices.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit
import Alamofire

protocol APIServicesProtocol {
    func fetchPosts(completion: @escaping (Result<[Post],Error>)-> Void)
    func fetchComments(postId: Int, completion: @escaping(Result<[Comment],Error>)-> Void)
}

class APIServices: APIServicesProtocol {
    
    static let shared = APIServices()
    private let networking = NetworkingClient.shared
    
    private init() {}
    
    
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = APIConfig.shared.getApiURL(path: .posts)
        networking.didRequest(
            url: url,
            method: .get,
            completion: completion
        )
    }
    
    func fetchComments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let url = APIConfig.shared.getApiURLComments(postId: postId)
        networking.didRequest(
            url: url,
            completion: completion
        )
    }
    
}
