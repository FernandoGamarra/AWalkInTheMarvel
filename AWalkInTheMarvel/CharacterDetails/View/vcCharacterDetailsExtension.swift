//
//  vcCharacterDetailsExtension.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 21/4/22.
//

import UIKit


// MARK: UITableViewDelegate implementation
extension vcCharacterDetails: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var retValue: CGFloat = 0
        
        if viewModel != nil {
        
            switch (indexPath.section) {
                
            case TBL_SECTION_DETAILS_GENERAL:
                let (_, description, _, _) = viewModel.getGeneralDetails()
                retValue = description.count > 0 ? 240 : 160
            case TBL_SECTION_DETAILS_COMICS,
                 TBL_SECTION_DETAILS_SERIES,
                 TBL_SECTION_DETAILS_STORIES,
                 TBL_SECTION_DETAILS_EVENTS:
                retValue = 46
            default:
                break
            }
            
        }
        
        return retValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section) {
            
        case TBL_SECTION_DETAILS_GENERAL:
            break
        case TBL_SECTION_DETAILS_COMICS:
            break
        case TBL_SECTION_DETAILS_SERIES:
            break
        case TBL_SECTION_DETAILS_STORIES:
            break
        case TBL_SECTION_DETAILS_EVENTS:
            break
        default:
            break
        }

        
    }
    
}

// MARK: UITableViewDataSource implementation
extension vcCharacterDetails: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var retVal = 0
        
        switch (section) {
        case TBL_SECTION_DETAILS_GENERAL:
            retVal = 1
        case TBL_SECTION_DETAILS_COMICS,
             TBL_SECTION_DETAILS_SERIES,
             TBL_SECTION_DETAILS_STORIES,
             TBL_SECTION_DETAILS_EVENTS:
            if viewModel != nil {
                retVal = viewModel.getItemsDetailsCountByType(section)
            }
        default:
            break
        }

        return retVal
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String? = nil
        
        switch (section) {
        case TBL_SECTION_DETAILS_GENERAL:
            break
        case TBL_SECTION_DETAILS_COMICS,
             TBL_SECTION_DETAILS_SERIES,
             TBL_SECTION_DETAILS_STORIES,
             TBL_SECTION_DETAILS_EVENTS:
            title = getHeaderTitle(section: section)
        default:
            break
        }
        
        if title != nil {
            if viewModel != nil {
                title = "\(viewModel.getItemsDetailsCountByType(section)) " + title!
            }
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView: UIView? = nil
        var title: UILabel = UILabel()
        
        switch (section) {
        case TBL_SECTION_DETAILS_GENERAL:
            break
        case TBL_SECTION_DETAILS_COMICS,
             TBL_SECTION_DETAILS_SERIES,
             TBL_SECTION_DETAILS_STORIES,
             TBL_SECTION_DETAILS_EVENTS:
            
            headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70))
            //headerView?.backgroundColor = Colors.AppBackground
            headerView?.layer.backgroundColor = Colors.AppBackground.cgColor
            if let title_text = getHeaderTitle(section: section) {
                title = UILabel(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 10, height: 18))
                title.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .bold)
                title.font = title.font.withSize(18)
                title.text = title_text
                title.textColor = .red
            }
            headerView?.addSubview(title)
            
        default:
            break
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()

        switch (indexPath.section) {
        case TBL_SECTION_DETAILS_GENERAL:
            cell = prepareDetailsGeneralCell(tableView, indexPath)
        case TBL_SECTION_DETAILS_COMICS,
             TBL_SECTION_DETAILS_SERIES,
             TBL_SECTION_DETAILS_STORIES,
             TBL_SECTION_DETAILS_EVENTS:
            if let newCell = factoryDetailsItemsCell(tableView, indexPath, indexPath.section) {
                cell = newCell
            }
        default:
            break
        }

        return cell
    }

    func prepareDetailsGeneralCell(_ tableView:UITableView, _ indexPath: IndexPath) -> CharacterDetailsGeneralCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellCharacterDetailsGeneral, for: indexPath) as? CharacterDetailsGeneralCell else { fatalError("xib does not exists") }

        if viewModel != nil {
            (cell.lblCharacterName.text,
             cell.lblCharacterDescription.text,
             cell.lblCharacterLastModifDate.text,
             cell.imgCharacter.image) = viewModel.getGeneralDetails()
        }
        
        return cell

    }
    
    func factoryDetailsItemsCell(_ tableView:UITableView, _ indexPath: IndexPath, _ section: Int) -> UITableViewCell? {
        var cell: CharacterDetailsItemsCell? = nil
        
        switch (indexPath.section) {
        case TBL_SECTION_DETAILS_GENERAL:
            break
        case TBL_SECTION_DETAILS_COMICS:
            cell = tableView.dequeueReusableCell(withIdentifier: cellCharacterDetailsComics, for: indexPath) as? CharacterDetailsItemsCell
        case TBL_SECTION_DETAILS_SERIES:
            cell = tableView.dequeueReusableCell(withIdentifier: cellCharacterDetailsSeries, for: indexPath) as? CharacterDetailsItemsCell
        case TBL_SECTION_DETAILS_STORIES:
            cell = tableView.dequeueReusableCell(withIdentifier: cellCharacterDetailsStories, for: indexPath) as? CharacterDetailsItemsCell
        case TBL_SECTION_DETAILS_EVENTS:
            cell = tableView.dequeueReusableCell(withIdentifier: cellCharacterDetailsEvents, for: indexPath) as? CharacterDetailsItemsCell
        default:
            break
        }

        guard (cell != nil) else { fatalError("xib does not exists") }
            
        if viewModel != nil {
            (cell!.lblItemDescription.text,
             cell!.urlItem) = viewModel.getItemsDetails(type: indexPath.section, order: indexPath.row)
        }
        
        
        return cell
    }
    
    private func getHeaderTitle(section: Int) -> String? {
        var title: String? = nil
        
        switch (section) {
        case TBL_SECTION_DETAILS_GENERAL:
            break
        case TBL_SECTION_DETAILS_COMICS:
            title = "COMICS"
        case TBL_SECTION_DETAILS_SERIES:
            title = "SERIES"
        case TBL_SECTION_DETAILS_STORIES:
            title = "STORIES"
        case TBL_SECTION_DETAILS_EVENTS:
            title = "EVENTS"
        default:
            break
        }
        
        if title != nil {
            if viewModel != nil {
                title = "\(viewModel.getItemsDetailsCountByType(section)) " + title!
            }
        }
        
        return title
    }
    
}
