//
//  ApiConfig.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import Foundation

final class APIConfig {
    
    static let shared = APIConfig()
    
    private init() {}
    
    fileprivate let baseUrl = "https://jsonplaceholder.typicode.com"
    
    func getApiBaseUrl() -> String {
        return baseUrl
    }
    
    func getApiURL(path : APIPath) -> URL {
        let urlStr = "\(baseUrl)/\(path.rawValue)"
        return URL(string: urlStr)!
    }
    
    func getApiURLComments(postId: Int) -> URL{
        let urlStr = "\(baseUrl)/\(APIPath.posts.rawValue)/\(postId)/\(APIPath.comments.rawValue)"
        return URL(string: urlStr)!
    }
    
    func getApiURL(route: APIRoute, path : APIPath) -> URL {
        let urlStr = "\(baseUrl)/\(route.rawValue)/\(path.rawValue)"
        return URL(string: urlStr)!
    }
    
    func getApiURL(route: APIRoute, path: APIPath, subDir: [String]) -> URL {
        var urlStr = "\(baseUrl)/\(route.rawValue)/\(path.rawValue)"
        for dir in subDir {
            urlStr += "/\(dir)"
        }
        return URL(string: urlStr)!
    }
}
