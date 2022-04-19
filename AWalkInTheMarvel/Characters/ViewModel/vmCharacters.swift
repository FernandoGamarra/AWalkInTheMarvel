//
//  vmCharacters.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 17/4/22.
//

import UIKit
import AlamofireImage

class vmCharacters: NSObject {
    
    private var commsServices: helperCommsAF = helperCommsAF.shared()
    
    private var totalCharactersInWeb: Int = 0
    private var totalCharactersInLocal: Int = 0
    
    var reloadTable: (() -> Void)?
    var reloadCell: ((IndexPath) -> Void)?
    
    var charactersCellVM = [vmCharacterCell]() {
        didSet {
            //reloadTable?()
        }
        
    }
    
    override init() {
        super.init()
    }
    
    func getCharacters() {
        
        if totalCharactersInLocal == 0 || totalCharactersInLocal < totalCharactersInWeb {
        
            let charactersRequest: baseRequest = baseRequest(.GET_CHARACTERS, offset: totalCharactersInLocal)
            
            commsServices.callRequest(request: charactersRequest, params: nil) { [self] (results: dataCharacter?, error) in
                if error == nil {
                    processCharacters(results!)
                }
                else {
                    print(error!)
                }
            }
            
        }
    }
    
    func processCharacters(_ characters: dataCharacter) {
        
        if characters.content!.resultsCharacters!.count > 0 {
            
            totalCharactersInWeb = (characters.content?.totalCharactersInWeb)!
            totalCharactersInLocal += (characters.content?.countCharactersInPage)!
        
            var tmpAllCharacters = charactersCellVM
            
            for chardata in characters.content!.resultsCharacters! {
                if let charElem = prepareCellContent(chardata) {
                    
                    tmpAllCharacters.append(charElem)
                }
            }
            
            charactersCellVM = tmpAllCharacters
            
            reloadTable?()
            
            getCharacters()
    
        }
        
    }
    
    func prepareCellContent(_ character: characterProperties) -> vmCharacterCell? {
        
        var vmCell: vmCharacterCell? = nil
        
        if let filename = character.thumbnail?.path, let fileext = character.thumbnail?.fileExtension {
            let imagePathCharacter = "\(filename).\(fileext)"
            vmCell = vmCharacterCell(id: character.id!, name: character.name!, description: character.description!, imagePath: imagePathCharacter, image: nil)
        }
        
        return vmCell
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> vmCharacterCell {
        return charactersCellVM[indexPath.row]
    }
    
    func downloadCharacterImage(index: IndexPath, url: String) {
        
        commsServices.downloadImage(url: url) { [self] image, error in
            if error == nil && image != nil {
                let newImage = image!.af.imageRoundedIntoCircle()
                charactersCellVM[index.row].image = newImage
                reloadCell?(index)
            }
            else {
                print(error!)
            }
        }
    }

}
