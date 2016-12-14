//
//  ProductListManager.swift
//  TestTask
//
//  Created by Ilya Lapan on 14/12/2016.
//  Copyright © 2016 ilyalapan. All rights reserved.
//

import Foundation

class ProductListManager: Loadable,Pagination {
    
    var products: [[Product]] = [[]]
    
    var daysAgo: Int = 0
    
    var category: String
    
    
    var numberOfDays: Int {
        get {
            return daysAgo + 1
        }
    }
    
    
    //MARK: Loadable
    
    func getURLFetchString() -> String {
        return "https://api.producthunt.com/v1/categories/\(self.category)/posts"
    }
    
    
    func loadArray(array: Array<Dictionary<String, AnyObject>> ){
        self.products = [[]]
        for productDict in array{
            let product = Product(dict: postDict)
            self.posts.append(post)
        }
    }
    
    //MARK: Pagination
    
    func updateArray(array: Array<Dictionary<String, AnyObject>> ){
        for postDict in array{
            let post = FeedPost(dict: postDict)
            self.posts.append(post)
        }
    }
    
    
    func getURLMoreString(category: String) -> String {
        return "https://api.producthunt.com/v1/categories/\(self.category)/posts/days_ago=" + String(daysAgo)
    }
    
    func count() -> Int {
        return self.posts.count
    }

    
}




