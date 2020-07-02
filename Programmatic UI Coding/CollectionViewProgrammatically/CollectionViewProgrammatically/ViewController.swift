//
//  ViewController.swift
//  CollectionViewProgrammatically
//
//  Created by Hao Lam on 7/1/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit
//indentifiers
private let headerIdentifier = "ProfileHeader"
private let cellIdentifier = "ProfileCell"
class ViewController: UICollectionViewController {


    //array images
    var images:[UIImage]=[#imageLiteral(resourceName: "img2"), #imageLiteral(resourceName: "img9"), #imageLiteral(resourceName: "img8"),#imageLiteral(resourceName: "img3"),#imageLiteral(resourceName: "img5"),#imageLiteral(resourceName: "img7"),#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "img6"),#imageLiteral(resourceName: "img10"),#imageLiteral(resourceName: "img4")]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        //register Profile Header
        self.collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        //uptop iphone X gap fill-in.
        collectionView.contentInsetAdjustmentBehavior = .never
        
        //register image cell
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

// MARK: -UICollectionViewDelegate/DataSource
extension ViewController {
    // - FOR HEADER
    //get the header to show up
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        
        //header.emailLabel.backgroundColor = .red
        
        return header
        
    }
    
     // - FOR IMAGE CELL
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        cell.image = images[indexPath.row]
        return cell
    }
}
// MARK: -UICollectionViewDelegateFlowLayout
extension ViewController:UICollectionViewDelegateFlowLayout
{
    // - FOR HEADER SIZE
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        //define the sizes of header
        return CGSize(width: view.frame.width, height: 300)
    }
    // - FOR IMAGE CELL SIZE
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 4)/3  //3 cell in 1 row
        return CGSize(width: width, height: width) //making a square w x w
    }
    
    //Set amount of spacing around each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //Set amount of spacing around each row or column
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

