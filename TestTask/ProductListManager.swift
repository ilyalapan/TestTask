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
    
    var category: String = "tech"
    
    
    func getNumberOfProductsForSection(section: Int) -> Int {
        return products[section].count
    }
    
    
    //MARK: Loadable
    
    func getURLFetchString() -> String {
        return "https://api.producthunt.com/v1/categories/\(self.category)/posts?access_token=591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
    }
    
    
    func loadArray(array: Dictionary<String, AnyObject> ){
        self.products = [[]]
        if let array = array["posts"] as? Array<Dictionary<String, AnyObject>>{
            for productDict in array{
                let product = Product(dict: productDict)
                self.products[0].append(product)
            }
        }
    }

    
    
    //MARK: Pagination
    
    func updateArray(array: Dictionary<String, AnyObject> ){
        var productsArray = [Product]()
        if let array = array["posts"] as? Array<Dictionary<String, AnyObject>>{
            for productDict in array{
                let product = Product(dict: productDict)
                productsArray.append(product)
            }
        }
        self.products.append(productsArray)
    }
    
    
    func getURLMoreString() -> String {
        return "https://api.producthunt.com/v1/categories/\(self.category)/posts?days_ago=" + String(products.count + 1) + "&access_token=591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
    }
    
    
}




