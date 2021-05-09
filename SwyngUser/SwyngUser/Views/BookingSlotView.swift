//
//  BookingSlotView.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 06/05/21.
//

import Foundation
import UIKit

class BookingSlotView:UIView{
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var nslcCollectionHeight:NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "BookingSlotCell", bundle: nil), forCellWithReuseIdentifier: "BookingSlotCell")
        collectionView.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: .new, context: nil)
    }
    
    
}


//MARK: - COLLECTIONVIEW DELEGATE
extension BookingSlotView:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcCollectionHeight.constant = collectionView.contentSize.height
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingSlotCell", for: indexPath) as! BookingSlotCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width/2
        return CGSize(width: width, height: 40)
    }
}
