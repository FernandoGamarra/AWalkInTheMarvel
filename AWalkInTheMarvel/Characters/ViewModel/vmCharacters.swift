//
//  vmCharacters.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 17/4/22.
//

import UIKit

class vmCharacters: NSObject {
    
    private var commsServices: helperCommsAF = helperCommsAF.shared()
    
    var reloadTable: (() -> Void)?
    
    var charactersCellVM = [vmCharacterCell]() {
        didSet {
            reloadTable?()
        }
        
    }
    
    override init() {
        super.init()
    }
    
    func getCharacters() {
        
        let charactersRequest: baseRequest = baseRequest(.GET_CHARACTERS)
        
        commsServices.call(request: charactersRequest, params: nil) { [self] (results: dataCharacter?, error) in
            if error == nil {
                processCharacters(results!)
            }
            else {
                print(error!)
            }
        }
    }
    
    func processCharacters(_ characters: dataCharacter) {
        
        if characters.content!.resultsCharacters!.count > 0 {
        
            var tmpAllCharacters = [vmCharacterCell]()
            
            for chardata in characters.content!.resultsCharacters! {
                if let charElem = prepareCellContent(chardata) {
                    tmpAllCharacters.append(charElem)
                }
            }
            
            charactersCellVM = tmpAllCharacters
    
        }
        
    }
    
    func prepareCellContent(_ character: characterProperties) -> vmCharacterCell? {
        
        var vmCell: vmCharacterCell? = nil
        
        if let filename = character.thumbnail?.path, let fileext = character.thumbnail?.fileExtension {
            let imagePathCharacter = "\(filename).\(fileext)"
            vmCell = vmCharacterCell(id: character.id!, name: character.name!, description: character.description!, imagePath: imagePathCharacter, image: UIImage())
        }
        
        return vmCell
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> vmCharacterCell {
           return charactersCellVM[indexPath.row]
       }

}
