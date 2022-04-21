//
//  CharacterDetailsItemsCell.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 21/4/22.
//

import UIKit

class CharacterDetailsItemsCell: UITableViewCell {
    
    
    
    @IBOutlet weak var lblItemDescription: UILabel!
    
    var urlItem: String? = nil
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
