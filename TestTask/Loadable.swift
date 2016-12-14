//
//  Loadable.swift
//  TestTask
//
//  Created by Ilya Lapan on 14/12/2016.
//  Copyright © 2016 ilyalapan. All rights reserved.
//


import Foundation
import Alamofire

protocol Loadable {
    
    func load( completed: @escaping (ServerRequestResponse)  -> Void )
    func getURLFetchString() -> String
    func loadArray(array: Dictionary<String,AnyObject> )
        
}

extension Loadable {
    
    func load( completed: @escaping (ServerRequestResponse)  -> Void )  {
        
        let URLString = self.getURLFetchString()
        
        Alamofire.request(URLString).responseJSON{ response in
            
            do {
                let postsArray = try RequestHelper.checkResponse(responseJSON: response)
                self.loadArray(array: postsArray)
                completed(ServerRequestResponse.Success)
            }
            catch {
                print("Uncaught Error")
            }
        }
    }
    
}
