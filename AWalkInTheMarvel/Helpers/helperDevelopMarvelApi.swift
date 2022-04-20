//
//  helperDevelopMarvelApi.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 15/4/22.
//

import Foundation


class helperDevelopMarvelApi {
    
    let privateKey = "be8b66b5515b92d8297745e45dd34e3e306a273f"
    let publicKey = "6fc7aa73891a14e88a20a4425e522009"
    
    var hashParam: String {
        let timestamp = Date().currentTimeInMillis()
        return "&ts=\(timestamp)&hash=" + ("\(timestamp)\(privateKey)\(publicKey)".md5Value)
    }

    
    func getUrl(_ functionType: eApiFunction, offset: Int? = nil, id: Int? = nil) -> String {
        
        var url: String = defsApi.baseAddress
        url += getFunctionUrl(functionType, id: id)
        url += "?limit=100&apikey=\(publicKey)"
        if offset != nil {
            url += "&offset=\(offset!)"
        }
        url += hashParam
        
        return url
        
    }
    
    func getUrl(_ functionType: eApiFunction, offset: Int? = nil, id: Int? = nil) -> URL {
        return URL(string: self.getUrl(functionType, offset: offset, id: id))!
    }
    
    private func getFunctionUrl(_ functionType: eApiFunction, id: Int? = nil) ->  String  {
        var functionUrl: String!
        
        switch functionType {
        case .GET_CHARACTERS:
            functionUrl = defsApi.charactersAddress
            break
        case .GET_CHARACTER_DETAILS:
            if id != nil {
                functionUrl = defsApi.characterDetailsAddress
                functionUrl += "\(id!)"
            }
            else {
                functionUrl = ""
            }
            break
        default:
            functionUrl = ""
            break
        }
        

        return functionUrl
    }
    
}
