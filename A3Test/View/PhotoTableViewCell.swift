//
//  PhotoTableViewCell.swift
//  A3Test
//
//  Created by Александр Сахнюков on 13/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var photoTitleLable: UILabel!
    @IBOutlet weak var mainBack: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        myActivityIndicator.hidesWhenStopped = true
        myActivityIndicator.center = photoView.center
        myActivityIndicator.startAnimating()
        self.photoView.addSubview(myActivityIndicator)
        
        
            backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            
            self.mainBack.layer.borderWidth = 1
            self.mainBack.layer.cornerRadius = 3
            self.mainBack.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.mainBack.layer.masksToBounds = true
            
            self.layer.shadowOpacity = 0.28
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowRadius = 3
            self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.layer.masksToBounds = false
        }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

