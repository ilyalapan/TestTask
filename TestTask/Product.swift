//
//  Product.swift
//  TestTask
//
//  Created by Ilya Lapan on 14/12/2016.
//  Copyright © 2016 ilyalapan. All rights reserved.
//

import Foundation


class Product {
    
    var id: Int
    
    var name: String
    
    var tagline: String
    
    var upvotes: Int
    
    var imageURL: URL
    
    var screenShotURL: URL
    
    var detailURL: URL
    //var date: Date
    
    init(dict: [String: AnyObject]) {
        
        self.id = dict["id"] as! Int
        self.name = dict["name"] as! String
        self.tagline = dict["tagline"] as! String
        self.upvotes = dict["votes_count"] as! Int
        var thumbnail = dict["thumbnail"] as! Dictionary<String,AnyObject>
        self.imageURL = URL(string: thumbnail["image_url"]! as! String)!
        var screenShot = dict["screenshot_url"] as! Dictionary<String,AnyObject>
        self.screenShotURL = URL(string: screenShot["850px"]! as! String)!
        self.detailURL = URL(string: dict["discussion_url"] as! String)!
        
    }
    
    static func subtractArraysOfProdcuts(firstArray: [Product], secondArray: [Product]) -> [Product] {
        var new = [Product]()
        var contains = false
        for p1 in firstArray {
            contains = false;
            for p2 in secondArray {
                if p1.id == p2.id {
                    contains = true
                    break
                }
            }
            if !contains {
                new.append(p1)
            }
        }
        return new
    }

    
}
