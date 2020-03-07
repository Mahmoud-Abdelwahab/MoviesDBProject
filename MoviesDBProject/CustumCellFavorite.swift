//
//  CustumCellFavorite.swift
//  MoviesDBProject
//
//  Created by kasper on 3/7/20.
//  Copyright © 2020 kasper. All rights reserved.
//

import UIKit

class CustumCellFavorite: UITableViewCell {

    @IBOutlet weak var Fav_Image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
