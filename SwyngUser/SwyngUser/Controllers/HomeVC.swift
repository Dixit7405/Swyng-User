//
//  HomeVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 25/04/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController {
    @IBOutlet weak var clctnBanners:UICollectionView!
    @IBOutlet weak var pageControlBanner:UIPageControl!
    @IBOutlet weak var tblUpcomming:UITableView!
    @IBOutlet weak var nslcUpcommingTableHeight:NSLayoutConstraint!
    @IBOutlet weak var tblMembershipPlans:UITableView!
    @IBOutlet weak var nslcMembershipHeight:NSLayoutConstraint!
    @IBOutlet weak var viewNeedhelpShadow:UIView!
    @IBOutlet weak var viewBulkbookingShadow:UIView!
    @IBOutlet weak var viewUpcommingMain:UIView!
    @IBOutlet weak var tblSportsCoaching:UITableView!
    @IBOutlet weak var nslcSportCoachingHeight:NSLayoutConstraint!
    @IBOutlet weak var viewAccountShadow:UIView!
    
    
    var arrOpenEnquiery:[Bool] = Array(repeating: false, count: 2)
    let disposeBag = DisposeBag()
    var firstTimeOpen = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        self.addLeftBarButton()
        self.addRightBarButton()
        self.navigationItem.title = "Hello Champion!"
        
        tblUpcomming.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        tblMembershipPlans.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        tblSportsCoaching.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        viewNeedhelpShadow.dropShadow(color: UIColor.black, opacity: 0.5)
        viewBulkbookingShadow.dropShadow(color: UIColor.black, opacity: 0.5)
        viewAccountShadow.dropShadow(color: UIColor.black, opacity: 0.5)
        setupUpcomingTable()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ApplicationManager.cityId == nil{
            let vc:CitySelectionVC = .controller(storyId: "Main")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        else if firstTimeOpen{
            firstTimeOpen = false
            let vc:AccountInfoVC = AccountInfoVC.controller()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        /*else if ApplicationManager.sportType == nil{
            let vc:ManageCenterVC = .controller()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            return
        }*/
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewNeedhelpShadow.updateShadowPath()
        viewBulkbookingShadow.updateShadowPath()
        viewBulkbookingShadow.updateShadowPath()
    }
    
    func setupUpcomingTable(){
        let arr = Observable.just(["ab", "cd"])
        arr.bind(to: tblUpcomming.rx.items(cellIdentifier: "UpcommingCourtBookingCell", cellType: UpcommingCourtBookingCell.self)){ index, model, cell in
            cell.layoutIfNeeded()
        }
        .disposed(by: disposeBag)
        tblUpcomming.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

//MARK: - TABLEVIEW DELEGATES
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UITableView.contentSize){
            nslcUpcommingTableHeight.constant = tblUpcomming.contentSize.height
            nslcMembershipHeight.constant = tblMembershipPlans.contentSize.height
            nslcSportCoachingHeight.constant = tblSportsCoaching.contentSize.height
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*if tableView == tblUpcomming{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingCourtBookingCell", for: indexPath) as! UpcommingCourtBookingCell
            
            return cell
        }
        else*/ if tableView == tblSportsCoaching{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SportsCoachingCell", for: indexPath) as! SportsCoachingCell
            cell.isOpenEnquiery = arrOpenEnquiery[indexPath.row]
            cell.enquiryChangeBlock = { isOpen in
                self.arrOpenEnquiery[indexPath.row] = !self.arrOpenEnquiery[indexPath.row]
                self.tblSportsCoaching.reloadSections([0], with: .automatic)
                
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MembershipPlanCell", for: indexPath) as! MembershipPlanCell
            
            return cell
        }
    }
}

//MARK: - COLLECTIONVIEW DELEGATES
extension HomeVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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

//MARK: - SCROLLVIEW DELEGATES
extension HomeVC{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == clctnBanners{
            if let indexPath = clctnBanners.indexPathForItem(at: CGPoint(x: scrollView.contentOffset.x+(scrollView.bounds.size.width/2), y: scrollView.bounds.size.height/2)){
                pageControlBanner.currentPage = indexPath.item
            }
        }
    }
}
