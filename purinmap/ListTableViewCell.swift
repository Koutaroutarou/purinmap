//
//  ListTableViewCell.swift
//  purinmap
//
//  Created by 渡辺航太郎 on 2019/05/13.
//  Copyright © 2019 litech. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet var star: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var picture: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
