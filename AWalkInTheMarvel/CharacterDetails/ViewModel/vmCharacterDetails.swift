//
//  vmCharacterDetails.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 20/4/22.
//

import UIKit
import CloudKit

enum eTypeItemDetails: Int {
    case DETAILS_GENERAL    = 0,
         DETAILS_COMICS,
         DETAILS_SERIES,
         DETAILS_STORIES,
         DETAILS_EVENTS
}

class vmCharacterDetails: NSObject {
    
    private var commsServices: helperCommsAF = helperCommsAF.shared()
    
    let idCharacter: Int!
    let imgCharacter: UIImage!
    var characterDetails: dataCharacterDetails? = nil
    
    var reloadTable: (() -> Void)?
    
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
                reloadTable?()
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
    
    func getGeneralDetails() -> (name: String, description: String, date: String, image: UIImage) {
        
        let dateConverted = UtilsDate.dateFromStringToFormat(dateToConvert: (characterDetails?.detailsCharacter?.content?.resultsCharacters![0].dateModified)!,
                                                             formatDate: FormatDate.EEEEMMMdyyyy)
        
        return (name: (characterDetails?.detailsCharacter?.content?.resultsCharacters![0].name)!,
                description: (characterDetails?.detailsCharacter?.content?.resultsCharacters![0].description)!,
                date: dateConverted,
                image: (characterDetails?.imgCharacter)!)
                
    }
    
    
    func getItemsDetails(type: Int, order: Int) -> (description: String, url: String)  {
        var descr: String = ""
        var url: String = ""
        
        if let allItems = self.getItemsDetailsByType(type) {
            if allItems.count > order {
                descr = allItems[order].name!
                url = allItems[order].URI!
            }
        }
        
        return (descr, url)
    }
    
    func getItemsDetailsByType(_ type: Int) -> [dataActivity]? {
        var retValue: [dataActivity]? = nil
        
        switch (eTypeItemDetails(rawValue: type)) {
        case .DETAILS_GENERAL:
            break
        case .DETAILS_COMICS:
            retValue = characterDetails?.detailsCharacter?.content?.resultsCharacters![0].comics?.items
        case .DETAILS_SERIES:
            retValue = characterDetails?.detailsCharacter?.content?.resultsCharacters![0].series?.items
        case .DETAILS_STORIES:
            retValue = characterDetails?.detailsCharacter?.content?.resultsCharacters![0].stories?.items
        case .DETAILS_EVENTS:
            retValue = characterDetails?.detailsCharacter?.content?.resultsCharacters![0].events?.items
        default:
            break
        }
        
        return retValue
    }
    
    func getItemsDetailsCountByType(_ type: Int) -> Int {
        var retValue = 0
        
        switch (eTypeItemDetails(rawValue: type)) {
        case .DETAILS_GENERAL:
            break
        case .DETAILS_COMICS:
            retValue = (characterDetails?.detailsCharacter?.content?.resultsCharacters![0].comics?.items!.count)!
        case .DETAILS_SERIES:
            retValue = (characterDetails?.detailsCharacter?.content?.resultsCharacters![0].series?.items!.count)!
        case .DETAILS_STORIES:
            retValue = (characterDetails?.detailsCharacter?.content?.resultsCharacters![0].stories?.items!.count)!
        case .DETAILS_EVENTS:
            retValue = (characterDetails?.detailsCharacter?.content?.resultsCharacters![0].events?.items!.count)!
        default:
            break
        }
        
        return retValue
    }
}
