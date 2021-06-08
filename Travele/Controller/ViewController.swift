//
//  ViewController.swift
//  Travele
//
//  Created by fahmi dwi on 02/06/21.
//  Copyright © 2021 Dicoding Indonesia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var placeTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var places = [PlaceModel]()
    var filteredPlaces = [PlaceModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        searchInput.delegate = self
        placeTableView.delegate = self
        placeTableView?.dataSource = self
        
        placeTableView?.register(UINib(nibName: "PlaceTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaceCell")
        
        profileImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.gotProfile))
        profileImage.addGestureRecognizer(gesture)
        
        getlistPlaces()
    }
    
    @objc func gotProfile(sender: UITapGestureRecognizer) {
        let profileVc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(profileVc, animated: true)
    }
    
    func setupView() {
        searchInput.placeholder = "Cari berdasarkan nama tempat wisata"
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        placeTableView.separatorStyle = .none
        placeTableView.rowHeight = UITableView.automaticDimension
        placeTableView.estimatedRowHeight = 45.0
    }
    
    private func getlistPlaces() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        ApiService<[PlaceModel]>.get(self, path: "places", url: "https://tourism-api.dicoding.dev/list") { (place) in
            self.places = place!
            DispatchQueue.main.async {
                self.loadingIndicator.isHidden = true
                self.loadingIndicator.stopAnimating()
                self.placeTableView.reloadData()
            }
        }
    }
    
    private func searchPlaces(value: String) {
        filteredPlaces = places
        if places.isEmpty == false {
            filteredPlaces = places.filter({ $0.name.lowercased().contains(value.lowercased()) })
        }
        
        placeTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count: Int = self.filteredPlaces.count == 0 ? self.places.count : self.filteredPlaces.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as? PlaceTableViewCell {
            cell.selectionStyle = .none
            cell.placeImage.layer.masksToBounds = true
            cell.placeImage.layer.cornerRadius = 10
            
            let place: PlaceModel = self.filteredPlaces.count == 0 ? self.places[indexPath.row] : self.filteredPlaces[indexPath.row]
            cell.placeName.text = place.name
            cell.placeDesc.text = place.description
            cell.countLike.text = String(place.like)
            cell.placeImage.loadImage(withUrl: place.image)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailPlaceViewController(nibName: "DetailPlaceViewController", bundle: nil)
        detail.place = self.places[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension ViewController: ApiServiceDelegate {
    func onError() {
        DispatchQueue.main.async() {
            let alert = UIAlertController(title: "Ups", message: "An error has occurred...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.searchPlaces(value: textField.text!)
    }
}

extension UIImageView {
    func loadImage(withUrl url: String) {
        guard let urlImage = URL(string: url) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: urlImage) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
