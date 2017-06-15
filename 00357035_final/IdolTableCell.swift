//
//  IdolTableCell.swift
//  00357035_final
//
//  Created by user_05 on 2017/5/24.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class IdolTableCell: UITableViewCell {
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var Name: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
