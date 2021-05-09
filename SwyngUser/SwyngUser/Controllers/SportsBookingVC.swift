//
//  SportsBookingVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 06/05/21.
//

import UIKit

class SportsBookingVC: UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: - ACTION METHODS
extension SportsBookingVC{
    @IBAction func btnNextPressed(_ sender:UIButton){
        let vc:BookingReviewVC = BookingReviewVC.controller()
        navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - TABLEVIEW DELEGATE
extension SportsBookingVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCourtCell", for: indexPath) as! BookingCourtCell
        return cell
    }
}

//MARK: - COLLECTIONVIEW DELEGATES
extension SportsBookingVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingDateCell", for: indexPath) as! BookingDateCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.height, height: collectionView.bounds.size.height)
    }
}
