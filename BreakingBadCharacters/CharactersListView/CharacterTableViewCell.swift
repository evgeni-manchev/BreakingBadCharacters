//
//  CharacterTableViewCell.swift
//  Breaking Bad Characters
//
//  Created by Evgeni Manchev on 27.01.21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    static let height: CGFloat = 200
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterName.lineBreakMode = .byWordWrapping
        characterName.numberOfLines = 3
        characterImage.contentMode = .scaleAspectFill
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.green026635.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
