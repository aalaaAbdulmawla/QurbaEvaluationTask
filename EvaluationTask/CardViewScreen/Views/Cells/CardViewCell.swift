//
//  CardViewCell.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/26/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import UIKit

class CardViewCell: UITableViewCell {

    @IBOutlet weak var placeProfilePic: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeCategories: UILabel!
    @IBOutlet weak var placeLocation: UILabel!
    @IBOutlet weak var placeAvalilability: UILabel!
    @IBOutlet weak var placeCoverImage: UIImageView!
    @IBOutlet weak var placeShortDiscription: UILabel!
    @IBOutlet weak var placeTags: UILabel!
    @IBOutlet var facilitiesImgs: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        placeProfilePic.image = nil
        placeCoverImage.image = nil
        for facilityImg in facilitiesImgs {
            facilityImg.image = nil
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellWith(_ cardViewModel: CardViewModel) {
        if let url = URL(string: cardViewModel.profileImg) {
            placeProfilePic.alomofireDownloadImageWithProgress(url)
        }
        if let url = URL(string: cardViewModel.coverImg) {
            placeCoverImage.alomofireDownloadImageWithProgress(url)
        }
        placeName.text = cardViewModel.name
        placeCategories.text = cardViewModel.categories
        placeLocation.text = cardViewModel.location
        setPlaceAvailabilityLabel(availableNow: cardViewModel.availability)
        placeShortDiscription.text = cardViewModel.shortDiscribtion
        placeTags.text = cardViewModel.hashTags
        for (index, img) in cardViewModel.facilitiesImgs.enumerated() {
            if index >= 7 { break }
            facilitiesImgs[index].image = UIImage(named: img)
        }
    }
    
    func setPlaceAvailabilityLabel(availableNow: AvailableNow) {
        placeAvalilability.text = availableNow.rawValue
        placeAvalilability.textColor = (availableNow == .Close) ? UIColor(red: 158.0/255.0, green: 158.0/255.0, blue: 158.0/255.0, alpha: 1.0) : UIColor(red: 44.0/255.0, green: 181.0/255.0, blue: 126.0/255.0, alpha: 1.0)
        
    }
    
}
