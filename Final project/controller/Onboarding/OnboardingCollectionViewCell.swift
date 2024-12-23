//
//  OnboardingCollectionViewCell.swift
//  Final project
//
//  Created by yunus on 16.12.2024.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    var nameImage: String = "" {
        didSet {
            imageView.image = UIImage(named: nameImage)
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
