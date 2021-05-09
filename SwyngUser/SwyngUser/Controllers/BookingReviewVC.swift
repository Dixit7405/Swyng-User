//
//  BookingReviewVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 07/05/21.
//

import UIKit

class BookingReviewVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var nslcTableHeight:NSLayoutConstraint!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var viewBookingId:UIView!
    @IBOutlet weak var stackCancelBooking:UIStackView!
    @IBOutlet weak var viewCancel:UIView!
    @IBOutlet weak var viewReschedule:UIView!
    @IBOutlet weak var viewAvailableOnRent:UIView!
    @IBOutlet weak var viewAvailableForSale:UIView!
    @IBOutlet weak var stackNeedHelp:UIStackView!
    @IBOutlet weak var viewBanners:UIView!
    @IBOutlet weak var viewCenterGuidelines:UIView!
    @IBOutlet weak var stackCancelCharges:UIStackView!
    
    enum PageType {
        case review
        case confirmed
        case upcoming
        case past
    }
    
    var pageType:PageType = .review
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        if pageType == .review{
            viewBookingId.isHidden = true
            stackCancelBooking.isHidden = true
            viewAvailableOnRent.isHidden = true
            viewAvailableForSale.isHidden = true
            stackNeedHelp.isHidden = true
            viewBanners.isHidden = true
            stackCancelCharges.isHidden = true
        }
        else if pageType == .past{
            stackCancelBooking.isHidden = true
            viewAvailableOnRent.isHidden = true
            viewAvailableForSale.isHidden = true
            stackNeedHelp.isHidden = true
            viewCenterGuidelines.isHidden = true
            stackCancelCharges.isHidden = true
        }
        else if pageType == .upcoming{
            viewAvailableOnRent.isHidden = true
            viewAvailableForSale.isHidden = true
            stackNeedHelp.isHidden = true
            viewCenterGuidelines.isHidden = true
            viewBanners.isHidden = true
            viewCancel.isHidden = true
            viewReschedule.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

}

//MARK: - ACTION METHODS
extension BookingReviewVC{
    @IBAction func btnNextPressed(_ sender:UIButton){
        let vc:BookingReviewVC = BookingReviewVC.controller()
        vc.pageType = .confirmed
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - TABLEVIEW DELEGATES
extension BookingReviewVC:UITableViewDelegate,UITableViewDataSource{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcTableHeight.constant = tableView.contentSize.height
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingReviewCell", for: indexPath) as! BookingReviewCell
        cell.btnClose.isHidden = pageType == .past
        if pageType == .upcoming{
            cell.btnClose.setImage(#imageLiteral(resourceName: "radio_empty"), for: .normal)
            cell.btnClose.setImage(#imageLiteral(resourceName: "confirm_red 5"), for: .selected)
        }
        else{
            cell.btnClose.setImage(#imageLiteral(resourceName: "close"), for: .normal)
            cell.btnClose.setImage(#imageLiteral(resourceName: "close"), for: .selected)
        }
        return cell
    }
    
    
}

//MARK: - COLLECTIONVIEW DELEGATES
extension BookingReviewVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCell", for: indexPath) as! HomeBannerCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

