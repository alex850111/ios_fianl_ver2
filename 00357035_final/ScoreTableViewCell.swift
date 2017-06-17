//
//  ScoreTableViewCell.swift
//  00357035_final
//
//  Created by mari on 2017/6/17.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    @IBOutlet weak var photo_icon: UIImageView!
    @IBOutlet weak var photo_text: UITextField!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
