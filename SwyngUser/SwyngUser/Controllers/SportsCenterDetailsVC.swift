//
//  SportsCenterDetailsVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 05/05/21.
//

import UIKit

class SportsCenterDetailsVC: BaseVC {
    @IBOutlet weak var collectionGallery:UICollectionView!
    @IBOutlet weak var lblAddress:UILabel!
    @IBOutlet weak var btnMapDirection:UIButton!
    @IBOutlet weak var lblAboutCenterHeading:UILabel!
    @IBOutlet weak var lblAboutCenter:UILabel!
    @IBOutlet weak var lblAvailableHours:UILabel!
    @IBOutlet weak var lblAmenities:UILabel!
    @IBOutlet weak var lblCenterGuidelines:UILabel!
    @IBOutlet weak var lblAvailableOnRent:UILabel!
    @IBOutlet weak var lblAvailableForSale:UILabel!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var scrollView:UIScrollView!
    
    var centerId = 0
    var sportCenterDetail:SportCentersDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.isHidden = true
        getSportDetails()
        // Do any additional setup after loading the view.
    }

}

//MARK: - CUSTOM METHODS
extension SportsCenterDetailsVC{
    private func setData(){
        guard let sportDetail = self.sportCenterDetail else {return}
        self.scrollView.isHidden = false
        lblTitle.text = sportDetail.sport?.centerTitle
        lblAddress.text = sportDetail.sport?.address
        lblAboutCenterHeading.text = "About \(sportDetail.sport?.sportCenter ?? "")"
        lblAboutCenter.text = sportDetail.sport?.about
        lblAvailableHours.text = sportDetail.sport?.openHours
        lblAmenities.text = sportDetail.sport?.amenities
        lblCenterGuidelines.text = sportDetail.sport?.centerGuidelines
        lblAvailableOnRent.text = sportDetail.sport?.availableOnRent
        lblAvailableForSale.text = sportDetail.sport?.availableForSale
        collectionGallery.reloadData()
    }
}

//MARK: - ACTION METHODS
extension SportsCenterDetailsVC{
    @IBAction func btnBookCourtPressed(_ sender:UIButton){
//        let vc:SportsBookingVC = SportsBookingVC.controller()
//        navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - COLLECTION DELEGATES
extension SportsCenterDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportCenterDetail?.gallery?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportGalleryCell", for: indexPath) as! SportGalleryCell
        let gallery = sportCenterDetail?.gallery?[indexPath.row]
        cell.imgGallery.setImage(from: gallery?.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.size.width-65)/4
        return CGSize(width: size, height: size)
    }
}

//MARK: - API SERVICE
extension SportsCenterDetailsVC{
    private func getSportDetails(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.id:centerId]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getSportCenterDetails, type: CommonResponse<SportCentersDetails>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<SportCentersDetails>, let data = self.successBlock(response: response){
                self.sportCenterDetail = data
                self.setData()
            }
        }
    }
}
