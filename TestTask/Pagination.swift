//
//  Loadable.swift
//  TestTask
//
//  Created by Ilya Lapan on 14/12/2016.
//  Copyright © 2016 ilyalapan. All rights reserved.
//


import Foundation
import Alamofire

protocol Pagination {
    
    func getURLMoreString() -> String
    func updateArray(array: [Dictionary<String,AnyObject>] )
    func loadMore(idToken: String, completed: @escaping (ServerRequestResponse) -> Void )
    
}

extension Pagination {
    
    func loadMore(idToken: String = "", completed: @escaping (ServerRequestResponse) -> Void )  {
        var headers : Dictionary<String,String> = [:]
        if idToken != "" {
            headers = ["Authorization": "Bearer " + idToken,]
        }
        let URLString = self.getURLMoreString()
        
        Alamofire.request(URLString, headers: headers).responseJSON{ response in
            
            do {
                let postsArray = try RequestHelper.checkResponse(responseJSON: response)
                self.updateArray(array: postsArray)
                completed(ServerRequestResponse.Success)
            }
            catch ServerResponseError.Empty {
                completed(ServerRequestResponse.Empty)
            }
            catch ServerResponseError.Unathorised {
                completed(ServerRequestResponse.Unathorised)
            } //TODO: Cath all the errors or it will crash!
            catch {
                assert(false, "Did not catch error with the response")
            }
        }
    }
    
}
