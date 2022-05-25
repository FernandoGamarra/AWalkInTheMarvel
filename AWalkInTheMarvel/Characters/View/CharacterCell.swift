//
//  CharacterCell.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 17/4/22.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var charNameLabel: UILabel!
    @IBOutlet weak var charDescriptionLabel: UILabel!
    var idCharacter: Int!
    
    var cellViewModel: ViewModelCharacterCell? {
            didSet {
                charNameLabel.text =  cellViewModel?.name
                charDescriptionLabel.text = cellViewModel?.description
                charImage.image = cellViewModel?.image
                idCharacter = cellViewModel?.id
            }
        }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView() {
        backgroundColor = Colors.AppBackground
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        charNameLabel.text = nil
        charDescriptionLabel.text = nil
    }
}
