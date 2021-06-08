//
//  PlaceTableViewCell.swift
//  Travele
//
//  Created by fahmi dwi on 02/06/21.
//  Copyright © 2021 Dicoding Indonesia. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeDesc: UILabel!
    @IBOutlet weak var countLike: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.placeImage.image = UIImage(named: "default-image")
    }
    
}
