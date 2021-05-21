//
//  APIPath.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import UIKit


// ROUTES FOR API
public enum APIRoute : String {
    case v1 = "v1"
}


// PATHS FOR REQUESTING THE SERVER
public enum APIPath: String {
    case posts = "posts"
    case comments = "comments"
}

public enum APIEndPoint {
    
    case comments(id: Int)
    case posts
    
    private var base: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var urlString: String {
        switch self {
        case .comments(let id):
            return generateUrlString(APIPath.posts.rawValue,String(id),APIPath.comments.rawValue)
        case .posts:
            return generateUrlString(APIPath.posts.rawValue)
        }
    }
    
    var url: URL {
        return URL(string: urlString)!
    }
    
    // MARK:- Private Method Helper
    private func generateUrlString(_ values: String ...)-> String {
        var urlStr = base
        values.forEach { value in
            urlStr += "/\(value)"
        }
        return urlStr
    }
}
