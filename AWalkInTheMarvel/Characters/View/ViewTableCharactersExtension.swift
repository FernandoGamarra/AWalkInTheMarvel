//
//  ViewTableCharactersExtension.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 17/4/22.
//

import UIKit

// MARK: UITableViewDelegate implementation
extension ViewTableCharacters: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//        return 130
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        if cellVM.description.count > 0 {
            return 160
        }
        else {
            return 110
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = storyboard?.instantiateViewController(identifier: "ViewCharacterDetails") as? ViewCharacterDetails {
            
            navigationController?.pushViewController(viewController, animated: true)
            indexPathSelectedRow = indexPath
            
        }
        
    }
}

// MARK: UITableViewDataSource implementation
extension ViewTableCharacters: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let retValue = viewModel.getNumberCharactersLoaded()
        LogApp.write(.Verbose, content: "\(#function): number rows in section \(retValue)")
        return retValue
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellCharacter, for: indexPath) as? CharacterCell else { fatalError("xib does not exists") }
        
        LogApp.write(.Verbose, content: "\(#function): \(indexPath.row)")
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        if cellVM.image == nil  {
            viewModel.downloadCharacterImage(index: indexPath, url: cellVM.imagePath)
        }
        cell.cellViewModel = cellVM
        
        return cell
    }
}
