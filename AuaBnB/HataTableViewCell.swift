//
//  HataTableViewCell.swift
//  AuaBnB
//
//  Created by user on 14.06.16.
//  Copyright © 2016 Roborzoid. All rights reserved.
//

import UIKit

class HataTableViewCell: UITableViewCell {

    @IBOutlet weak var hataImage: UIImageView!
    @IBOutlet weak var hataTitle: UILabel!
    @IBOutlet weak var hataPrice: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
