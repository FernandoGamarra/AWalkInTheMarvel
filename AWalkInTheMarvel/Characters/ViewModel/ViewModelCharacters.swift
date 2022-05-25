//
//  ViewModelCharacters.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 17/4/22.
//

import UIKit
import AlamofireImage

class ViewModelCharacters: NSObject {
    
    private var commsServices: HelperCommsAF = HelperCommsAF.shared()
    
    private var totalCharactersInWeb: Int = 0
    private var totalCharactersInLocal: Int = 0
    
    var reloadTable: (() -> Void)?
    var reloadCell: ((IndexPath) -> Void)?
    
    private let mSynchroFilter: NSLock = NSLock()
    private var mLettersFilter: String = ""
    
    var currentListCharacters: [Int] = [Int]()
    
    var charactersCellVM = [ViewModelCharacterCell]() {
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
            
            print("\(#function) TO Download Characters, with offset: \(totalCharactersInLocal)")
            
            commsServices.callRequest(request: charactersRequest, params: nil) { [self] (results: ModelCharacter?, error) in
                if error == nil {
                    processCharacters(results!)
                }
                else {
                    print(error!)
                }
                UtilsUI.hideWaitControl()
            }
            
        }
        else {
            print("\(#function) Completed download characters")
        }
    }
    
    func processCharacters(_ characters: ModelCharacter) {
        
        mSynchroFilter.lock()
        defer { mSynchroFilter.unlock() }
        
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
            
            print("\(#function) Current characters items: \(charactersCellVM.count)")
            
            if mLettersFilter.count > 0 {
                filterCharacters(letters: mLettersFilter)
            }
            
            reloadTable?()
            
        }
        
    }
    
    func prepareCellContent(_ character: characterProperties) -> ViewModelCharacterCell? {
        
        var vmCell: ViewModelCharacterCell? = nil
        
        if let filename = character.thumbnail?.path, let fileext = character.thumbnail?.fileExtension {
            let imagePathCharacter = "\(filename).\(fileext)"
            vmCell = ViewModelCharacterCell(id: character.id!, name: character.name!, description: character.description!, imagePath: imagePathCharacter, image: nil)
        }
        
        return vmCell
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ViewModelCharacterCell {
        
        if currentListCharacters.count == 0 {
            return charactersCellVM[indexPath.row]
        }
        else {
            print("\(#function): Query for row: \(indexPath.row), for a total of \(currentListCharacters.count) rows in filter")
            return charactersCellVM[currentListCharacters[indexPath.row]]
        }
    }
    
    func getNumberCharactersLoaded() -> Int {
        mSynchroFilter.lock()
        defer { mSynchroFilter.unlock() }
        
        if currentListCharacters.count > 0 {
            return currentListCharacters.count
        }
        else {
            return charactersCellVM.count
        }

    }
    
    func downloadCharacterImage(index: IndexPath, url: String) {
        
        commsServices.downloadImage(url: url) { [self] image, error in

            mSynchroFilter.lock()
            defer { mSynchroFilter.unlock() }
            
            let realIndex = self.getRealIndex(index)
            print("\(#function): \(index.row)   real[\(realIndex)]")

            if error == nil && image != nil {
                let newImage = image!.af.imageRoundedIntoCircle()
                charactersCellVM[realIndex].image = newImage
                reloadCell?(index)
            }
            else {
                print(error!)
            }
        }
    }
    
    func setCellImageDate(at indexPath: IndexPath, img: UIImage) {
        
        mSynchroFilter.lock()
        defer { mSynchroFilter.unlock() }
        
        if currentListCharacters.count == 0 {
            charactersCellVM[indexPath.row].image = img
        }
        else {
            charactersCellVM[currentListCharacters[indexPath.row]].image = img
        }
    }

    private func getRealIndex(_ index: IndexPath) -> Int {
        
        var retVal: Int = index.row
        
        if currentListCharacters.count > 0 {
            retVal = currentListCharacters[index.row]
        }
        
        return retVal
    }

    
    func filterCharacters(letters: String) {
        
        if letters.count == 0 {
            currentListCharacters.removeAll()
            mLettersFilter = letters
            print("\(#function) Current filter is [\(mLettersFilter)] and items filtered \(currentListCharacters.count)")
            reloadTable?()
        }
        else {
            DispatchQueue.global().async {
                self.setArrayWithFiltered(letters)
            }
            
        }
        
    }

    private func setArrayWithFiltered(_ letters: String) {
        
        mSynchroFilter.lock()
        defer { mSynchroFilter.unlock() }
        
        currentListCharacters.removeAll()
        
        charactersCellVM.enumerated().forEach { (index, element) in
            if element.name.uppercased().contains(letters.uppercased()) {
                currentListCharacters.append(index)
            }
        }
        
        mLettersFilter = letters
        
        print("\(#function) Current filter is [\(mLettersFilter)] and items filtered \(currentListCharacters.count)")
        
        reloadTable?()
        
    }


}
