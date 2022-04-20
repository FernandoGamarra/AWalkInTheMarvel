//
//  vmCharacterDetails.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 20/4/22.
//

import UIKit
import CloudKit

class vmCharacterDetails: NSObject {
    
    private var commsServices: helperCommsAF = helperCommsAF.shared()
    
    let idCharacter: Int!
    let imgCharacter: UIImage!
    var characterDetails: dataCharacterDetails? = nil
    
    init(idCharacter: Int, image: UIImage) {
        
        self.idCharacter = idCharacter
        self.imgCharacter = image
        
        super.init()
        
        self.initializations()
    }

    func initializations() {
        
        self.getCharacterDetails()
        
    }
    
    
    func getCharacterDetails() {
        
        let characterDetailsRequest: baseRequest = baseRequest(.GET_CHARACTER_DETAILS)
        characterDetailsRequest.setId(idCharacter)
        
        commsServices.callRequest(request: characterDetailsRequest, params: nil) { [self] (results: dataCharacter?, error) in
            if error == nil {
                processCharacterDetails(results!)
            }
            else {
                print(error!)
            }
        }
        
    }

    func processCharacterDetails(_ charDetails: dataCharacter) {
        
        characterDetails = dataCharacterDetails()
        characterDetails?.idCharacter = self.idCharacter
        characterDetails?.imgCharacter = self.imgCharacter
        characterDetails?.detailsCharacter = charDetails
        
    }
}
