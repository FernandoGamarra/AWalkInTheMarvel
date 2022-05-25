//
//  HelperCommsAF.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 16/4/22.
//

import UIKit
import Alamofire
import AlamofireImage

class HelperCommsAF {
    
    private let sessionManager: Session
    
    private static var sharedCommsAFManager: HelperCommsAF = {
        let apiManager = HelperCommsAF(sessionManager: Session())
        return apiManager
    }()
    
    // MARK: Accessor
    class func shared() -> HelperCommsAF {
        return sharedCommsAFManager
    }
    
    // MARK:  Init
    private init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    
    
    func callRequest<T>(request: IRequest, params: Parameters? = nil, handler: @escaping (T?, _ error: Error?)->()) where T: Codable {
        
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
                    handler(nil, self.parseError(data: response.data, code: request.apiFunc!.rawValue))
                    break
                }
            }
    }
    
    func downloadImage(url: String, handler: @escaping (UIImage?, _ error: Error?)->()) {
        
        
        self.sessionManager.request(url).responseImage { response in
            
            switch response.result {
            case .success(_):
                let img = UIImage(data: response.data!, scale: 1)
                handler(img, nil)
                break
            case .failure(_):
                handler(nil, self.parseError(data: response.data, code: eApiFunction.DOWNLOAD_IMAGE.rawValue))
                break
            }
        }
        
    }
    
    private func parseError(data: Data?, code: Int) -> Error {
        var retValue: NSError!
        
        if let jsonData = data, let error = try? JSONDecoder().decode(ErrorObj.self, from: jsonData) {
            retValue = NSError(domain: error.key!, code: code, userInfo: [NSLocalizedDescriptionKey: error.message!])
        }
        else {
            retValue = NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
        }
        
        return retValue
    }
    
    
}

class ErrorObj: Codable {
    let message: String?
    let key: String?
    
    enum CodingKeys: String, CodingKey {
        case message
        case key = "code"
    }
}




