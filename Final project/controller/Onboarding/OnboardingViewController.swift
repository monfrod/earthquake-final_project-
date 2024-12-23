//
//  OnboardingViewController.swift
//  Final project
//
//  Created by yunus on 16.12.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    static let KEY: String = "didSeeOnboarding"
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collView: UICollectionView!
    
    
    let images: [String] = ["image1", "image2", "image3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collView.dataSource = self
        collView.delegate = self
        
        collView.register(UINib(nibName: "OnboardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collCell")
        
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
    }
    
    override func viewDidLayoutSubviews() {
        nextButton.layer.cornerRadius = 10
        skipButton.layer.cornerRadius = 10
        
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        start()
    }
    
    @IBAction func NextButtonPressed(_ sender: Any) {
        if pageControl.currentPage == 2{
            start()
        } else {
            collView.contentOffset.x += view.frame.width
        }
    }
    
    func start(){
        print("aaa")
        
        UserDefaults.standard.set(true, forKey: OnboardingViewController.KEY)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateInitialViewController() {
            view.window?.rootViewController = tabBarController
        }
        
    }
    
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageControl.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.nameImage = images[indexPath.row]
        if indexPath.row == 0{
            cell.backgroundColor = .color1
        } else if indexPath.row == 2{
            cell.backgroundColor = .color2
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / view.frame.width)
        print(currentPage)
        pageControl.currentPage = currentPage
        if pageControl.currentPage == 2{
            nextButton.titleLabel?.text = "Start"
            skipButton.isHidden = true
        } else {
            nextButton.titleLabel?.text = "Next"
            skipButton.isHidden = false
        }
    }
    
}
