//
//  OnboardingViewController.swift
//  Final project
//
//  Created by yunus on 16.12.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collView: UICollectionView!
    
    
    let images: [UIImage?] = [UIImage(named: "image1"), UIImage(named: "image2"), UIImage(named: "image3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collView.dataSource = self
        collView.delegate = self
        
        collView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "collCell")
    }
    
    override func viewDidLayoutSubviews() {
        nextButton.layer.cornerRadius = 10
        skipButton.layer.cornerRadius = 10
        
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func NextButtonPressed(_ sender: Any) {
        
    }
    
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageControl.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.imageView.image = images[indexPath.row]
        
        return cell
    }
    
    
    
}
