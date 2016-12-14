import Foundation
import Alamofire

enum ServerRequestResponse: String {
    case Success = "successful"
    case Unathorised = "unauthorised"
    case BadRequest = "bad reqeust"
    case BadResponse = "bad response"
    case Other = "other"
    case Failed = "failed"
    case Empty = "empty"
    //TODO: expand
}

enum ServerResponseError : Error {
    case Unathorised
    case BadRequest
    case NoResponseStatus
    case BadResponse
    case Failed
    case Unknown
    case Empty
    
}

class RequestHelper { //TODO: possibly make this an extension of Alamofire
    
    static let helper = RequestHelper()
    
    
    
    
    static func checkResponse(responseJSON:  Alamofire.DataResponse<Any> ) throws -> Dictionary<String, AnyObject> {
        if let JSON = responseJSON.result.value {
            if let dict =  JSON as? Dictionary<String, AnyObject>{
                do {
                    try checkStatus(responseDict: dict)
                }
                //TODO: catch all errors
                return dict
            }
        }
        throw ServerResponseError.BadResponse
    }
    
    
    
    
    static func checkStatus(responseJSON: Alamofire.DataResponse<Any> ) throws  {
        if let JSON = responseJSON.result.value {
            if let dict =  JSON as? Dictionary<String, AnyObject>{
                do {
                    try checkStatus(responseDict: dict)
                    return
                }
            }
        }
        print("Bad Response")
        throw ServerResponseError.BadResponse
    }
    
    
    static func checkStatus(responseDict: Dictionary<String, AnyObject> ) throws  {
        if let rawValue = responseDict["status"] {
            if let status = ServerRequestResponse(rawValue: rawValue as! String) {
                switch status {
                case ServerRequestResponse.Success:
                    return
                default:
                    print("Unknown error")
                    throw ServerResponseError.Unknown
                }
            }
        }
    }
    
    
}
