//
//  RecipeTableViewCell.swift
//  yape-challenge
//
//  Created by devsodep on 24/04/2023.
//

import UIKit
import Kingfisher

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var hStackView: UIStackView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        recipeTitle.textColor = selected ? .gray : .black
    }

    func setCell(with data: RecipeModel) {
        contentView.backgroundColor = .white
        let url = data.image
        recipeImage.kf.setImage(with: URL(string: url)!)
        recipeImage.setCornerRadius()
        recipeTitle.text = data.title
    }
    
}
