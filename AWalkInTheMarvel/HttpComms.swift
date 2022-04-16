//
//  HttpComms.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 12/4/22.
//

import UIKit
import Alamofire
import CommonCrypto

class HtppComms {
    
    static let keyPrivate = "be8b66b5515b92d8297745e45dd34e3e306a273f"
    static let keyPublic = "6fc7aa73891a14e88a20a4425e522009"
    
    static func fetchCharacters() {
        
        // https://gist.github.com/informramiz/3d2be6985dd1f4378a83524629bd1541
        
        let ts = Date().currentTimeInMillis()
        let hashPrivateKey = "\(ts)\(keyPrivate)\(keyPublic)".md5Value
        
        var retvalue: dataCharacter!
        
        let request_str = "https://gateway.marvel.com:443/v1/public/characters?apikey=\(keyPublic)&ts=\(ts)&hash=\(hashPrivateKey)"
        
        let request = AF.request(request_str)
        
        request.validate()
        
//        request.responseDecodable(of: dataCharacter.self) { response in
//            print(response)
//            
//            if let marvelchars = response.value {
//                print(marvelchars)
//            }
//            
//        }
        
        
        
        request.responseJSON { data in
            print(data)

            do {
                
                retvalue = try JSONDecoder().decode(dataCharacter.self, from: data.data!)

                print("\(retvalue!)")

            } catch let errJSon {
                print("\(errJSon.localizedDescription)")
            }


        }
        
    }
    
}





