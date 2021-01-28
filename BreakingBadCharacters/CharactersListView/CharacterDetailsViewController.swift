//
//  CharacterDetailsViewController.swift
//  BreakingBadCharacters
//
//  Created by Evgeni Manchev on 28.01.21.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var character: Character? = nil
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var occupation: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var seasonAppearance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let character = character, let charImage = URL(string: character.img) {
            characterImage.kf.setImage(with: charImage)
            characterImage.contentMode = .scaleAspectFill
            characterImage.layer.borderWidth = 2
            occupation.lineBreakMode = .byWordWrapping
            occupation.numberOfLines = 3
            seasonAppearance.lineBreakMode = .byWordWrapping
            seasonAppearance.numberOfLines = 3
            
            name.text = "Name: " + character.name
            occupation.text = "Occupation: " + character.occupation.joined(separator: ", ")
            status.text = "Status: " + character.status.rawValue
            nickname.text = "Nickname: " + character.nickname
            seasonAppearance.text = "Season appearance: " + character.category.rawValue
        }
    }
    
}
