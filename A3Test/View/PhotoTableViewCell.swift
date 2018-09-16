//
//  PhotoTableViewCell.swift
//  A3Test
//
//  Created by Александр Сахнюков on 13/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var photoTitleLable: UILabel!
    @IBOutlet weak var mainBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func layoutSubviews() {

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
