//
//  SportsCenterDetailsVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 05/05/21.
//

import UIKit

class SportsCenterDetailsVC: UIViewController {
    @IBOutlet weak var collectionGallery:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: - ACTION METHODS
extension SportsCenterDetailsVC{
    @IBAction func btnBookCourtPressed(_ sender:UIButton){
        let vc:SportsBookingVC = SportsBookingVC.controller()
        navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - COLLECTION DELEGATES
extension SportsCenterDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportGalleryCell", for: indexPath) as! SportGalleryCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.size.width-65)/4
        return CGSize(width: size, height: size)
    }
}
