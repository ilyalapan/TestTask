//
//  Product.swift
//  TestTask
//
//  Created by Ilya Lapan on 14/12/2016.
//  Copyright © 2016 ilyalapan. All rights reserved.
//

import Foundation


class Product {
    var name: String
    
    var tagline: String
    
    var upvotes: Int
    
    //var date: Date
    
    init(dict: [String: AnyObject]) {
        self.name = dict["name"] as! String
        self.tagline = dict["tagline"] as! String
        self.upvotes = dict["votes_count"] as! Int
        //TODO: finish later self.date = Date(
    }

    
}
