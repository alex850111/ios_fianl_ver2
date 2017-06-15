//
//  CardTableViewCell.swift
//  00357035_final
//
//  Created by mari on 2017/5/27.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var cardIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
