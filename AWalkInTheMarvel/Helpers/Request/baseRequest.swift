//
//  baseRequest.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 16/4/22.
//

import UIKit
import Alamofire

protocol IRequest {
    var Url: String { get }
    var apiFunc: eApiFunction? { get set }
    var httpMethod: HTTPMethod { get set }
    var headers: HTTPHeaders? { get }
    
    func setApiFunc(_ funcApi: eApiFunction)
    func setHttpMethod(_ method: HTTPMethod)
    func getHttpMethod() -> HTTPMethod
    func getUrl() -> String
    func addHeader(headerName: String, headerValue: String)
    func getHeaders() -> HTTPHeaders?
    
}

class baseRequest: IRequest {
    internal var Url: String {
        if self.apiFunc != nil {
            return helperDevelopMarvelApi.getUrl(apiFunc!)
        }
        else {
            return ""
        }
    }
    
    internal var apiFunc: eApiFunction? = nil
    
    internal var httpMethod: HTTPMethod = .get
    
    internal var headers: HTTPHeaders? = nil
    
    init() {
    }
    
    init(_ httpMethod: HTTPMethod) {
        self.httpMethod = httpMethod
    }
    
    init(_ apiFunction: eApiFunction) {
        self.apiFunc = apiFunction
    }
    
    init(apiFunction: eApiFunction, httpMethod: HTTPMethod) {
        self.apiFunc = apiFunction
        self.httpMethod = httpMethod
    }
    func setApiFunc(_ funcApi: eApiFunction) {
        apiFunc = funcApi
    }
    
    func setHttpMethod(_ method: HTTPMethod) {
        httpMethod = method
    }
    
    func getHttpMethod() -> HTTPMethod {
        return httpMethod
    }
    
    func getUrl() -> String {
        return Url
    }
    
    func addHeader(headerName: String, headerValue: String) {
        
        if headers == nil {
            headers = []
        }
        
        let header = HTTPHeader(name: headerName, value: headerValue)
        headers?.add(header)
    }
    
    func getHeaders() -> HTTPHeaders? {
        return headers
    }
    
    
}
