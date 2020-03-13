//
//  CustomReviews.swift
//  MoviesDBProject
//
//  Created by kasper on 3/13/20.
//  Copyright © 2020 kasper. All rights reserved.
//

import UIKit

class CustomReviews: UITableViewCell {

    @IBOutlet weak var contentText: UILabel!
    
    @IBOutlet weak var user: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
