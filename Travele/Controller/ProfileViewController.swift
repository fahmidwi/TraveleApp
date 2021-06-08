//
//  ProfileViewController.swift
//  Travele
//
//  Created by fahmi dwi on 04/06/21.
//  Copyright © 2021 Dicoding Indonesia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.clickBackButton))
        self.backView.addGestureRecognizer(gesture)
    }
    
    private func setupView() {
        backView.layer.cornerRadius = backView.frame.height / 2
        backView.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
    }

    @objc func clickBackButton(sender : UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
}
