//
//  Comments.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
