//
//  DetailPlaceViewController.swift
//  Travele
//
//  Created by fahmi dwi on 03/06/21.
//  Copyright © 2021 Dicoding Indonesia. All rights reserved.
//

import UIKit

class DetailPlaceViewController: UIViewController {
    
    var place: PlaceModel?

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var placeLike: UILabel!
    @IBOutlet weak var placeDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setData()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.clickBackButton))
        self.backView.addGestureRecognizer(gesture)
    }
    
    @objc func clickBackButton(sender : UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setData()  {
        if let result = place {
            placeImage.loadImage(withUrl: result.image)
            placeName.text = result.name
            placeAddress.text = result.address
            placeDescription.text = result.description
            placeLike.text = String(result.like)
        }
    }
    
    private func setupView() {
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.30)
        backView.clipsToBounds = true
        backView.layer.cornerRadius = backView.frame.height / 2
    }
}
