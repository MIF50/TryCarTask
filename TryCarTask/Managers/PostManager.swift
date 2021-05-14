//
//  PostManager.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/13/21.
//

import Foundation
import RealmSwift

class Favorites: Object {
    let list = List<Int>()
}

class Store: Object {
    let list = List<Post>()
}

class PostManager {
    
    static let shared = PostManager()
    private var realm: Realm = try! Realm()

    private init() {}
    
    func cachePosts(posts: [Post]) {
        let store = Store()
        posts.forEach { post in
            store.list.append(post)
        }
        writeStore(store: store)
    }
    
    func getPosts()-> [Post] {
        guard let data = readStore() else { return [] }
        return data.list.toArray()
    }
    
    func updatePost(postId: Int) {
        if let favorites = readFavorites() {
            if favorites.list.contains(postId) { return }
            try! realm.write {
                favorites.list.append(postId)
                realm.add(favorites)
            }
        } else {
            let favorite = Favorites()
            favorite.list.append(postId)
            try! realm.write {
                realm.add(favorite)
            }
        }
    }
    
    func getFavorite()-> [Post] {
        guard let favorites = readFavorites() else { return [] }
        var posts = [Post]()
        favorites.list.forEach { id in
            if let data = readPost().filter("id=\(id)").first  {
                posts.append(data)
            }
        }
        return posts
    }
    
    private func readStore()-> Store? {
        guard let data = realm.objects(Store.self).first else { return nil }
        return data
    }
    
    private func readFavorites()-> Favorites? {
        let data = realm.objects(Favorites.self).first
        return data ?? nil
    }
    
    private func writeStore(store: Store) {
        deleteStore()
        try! realm.write {
            store.list.forEach { post in
                realm.add(post)
            }
            realm.add(store)
        }
    }
    
    private func deleteStore() {
        guard let data = readStore() else { return }
        try! realm.write {
            realm.delete(data)
        }
    }
    
    private func readPost()-> Results<Post> {
        return realm.objects(Post.self)
    }
}

extension Results {
    
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}

extension List {
    
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}
