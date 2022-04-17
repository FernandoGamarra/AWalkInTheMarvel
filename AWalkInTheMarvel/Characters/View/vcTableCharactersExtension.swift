//
//  vcTableCharactersExtension.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 17/4/22.
//

import UIKit

// MARK: UITableViewDelegate implementation
extension vcTableCharacters: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

// MARK: UITableViewDataSource implementation
extension vcTableCharacters: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.charactersCellVM.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellCharacter, for: indexPath) as? CharacterCell else { fatalError("xib does not exists") }
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        
        return cell
    }
}
