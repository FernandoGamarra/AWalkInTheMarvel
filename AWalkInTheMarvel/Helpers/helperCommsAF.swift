//
//  helperCommsAF.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 16/4/22.
//

import UIKit
import Alamofire

class helperCommsAF {
    
    private let sessionManager: Session
    
    private static var sharedCommsAFManager: helperCommsAF = {
        let apiManager = helperCommsAF(sessionManager: Session())
        return apiManager
    }()
    
    // MARK: Accessor
    class func shared() -> helperCommsAF {
        return sharedCommsAFManager
    }
    
    // MARK:  Init
    private init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    
    
    func call<T>(request: IRequest, params: Parameters? = nil, handler: @escaping (T?, _ error: Error?)->()) where T: Codable {
        
        self.sessionManager.request(request.getUrl(),
                                    method: request.getHttpMethod(),
                                    parameters: params,
                                    //encoding: <#T##ParameterEncoding#>,
                                    headers: request.getHeaders())
            .validate().responseJSON { response in
                switch response.result {
                case .success(_):
                    if let jsonResult = response.data {
                        let result_data = try! JSONDecoder().decode(T.self, from: jsonResult)
                        handler(result_data, nil)
                    }
                    break
                case .failure(_):
                    handler(nil, self.parseError(data: response.data))
                    break
                }
            }
    }
    
    private func parseError(data: Data?) -> Error {
        var retValue: Error!
        
        if let jsonData = data, let error = try? JSONDecoder().decode(ErrorObj.self, from: jsonData) {
            retValue = error as? Error
        }
        
        return retValue
    }
    
    
}

class ErrorObj: Codable {
    let message: String
    let key: String?
}




