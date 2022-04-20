//
//  CharacterDetailsGeneralCell.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 20/4/22.
//

import UIKit

class CharacterDetailsGeneralCell: UITableViewCell {
    
    
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var lblCharacterName: UILabel!
    @IBOutlet weak var lblCharacterDescription: UILabel!
    @IBOutlet weak var lblCharacterLastModifDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
