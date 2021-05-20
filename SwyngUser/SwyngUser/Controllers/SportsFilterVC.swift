//
//  SportsFilterVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 05/05/21.
//

import UIKit

class Filter{
    var sport:String?
    var category:String?
    var gallery:Bool?
    var filter:Bool?
}

protocol SportsFilterDelegate:AnyObject {
    func didApplyFilter(filter:Filter)
}

class SportsFilterVC: UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var btnApplySelection:UIButton!
    @IBOutlet weak var nslcCollectionHeight:NSLayoutConstraint!
    @IBOutlet weak var btnAllSports:UIButton!
    @IBOutlet weak var collectionSubCategory:UICollectionView!
    @IBOutlet weak var btnListGrid:UIButton!
    @IBOutlet weak var btnByDate:UIButton!
    @IBOutlet weak var nslcSubCatHeight:NSLayoutConstraint!
    
    var sportsArr:[String] = ["Badminton",
                              "Cricket",
                              "Running",
                              "Squash",
                              "Football",
                              "Table Tennis"]
    var selectedIndex:Int?{
        didSet{
            btnApplySelection.backgroundColor = selectedIndex != nil ? UIColor.AppColor.themeColor : UIColor.white
            btnApplySelection.setTitleColor(selectedIndex != nil ? UIColor.white : UIColor.black, for: .normal)
            btnApplySelection.isUserInteractionEnabled = selectedIndex != nil
            
            btnAllSports.backgroundColor = selectedIndex == nil ? UIColor.AppColor.themeColor : UIColor.white
            btnAllSports.setTitleColor(selectedIndex == nil ? UIColor.white : UIColor.black, for: .normal)
        }
    }
    
    var selectedSubCategory:Int?
    var showSubCategory = false
    
    weak var delegate:SportsFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        collectionView.reloadData()
        selectedIndex = nil
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: [NSKeyValueObservingOptions.new], context: nil)
        
        collectionSubCategory.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionSubCategory.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: [NSKeyValueObservingOptions.new], context: nil)
        // Do any additional setup after loading the view.
    }

}

//MARK: - ACTION METHODS
extension SportsFilterVC{
    @IBAction func btnApplySelectionPressed(_ sender:UIButton){
        self.dismissLeft { [unowned self] in
            let filter = Filter()
            filter.gallery = true
            self.delegate?.didApplyFilter(filter: filter)
        }
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        self.dismissLeft()
    }
    
    @IBAction func btnAllSportsPressed(_ sender:UIButton){
        selectedIndex = nil
        collectionView.reloadData()
    }
    
    @IBAction func btnListGridPressed(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        sender.backgroundColor = sender.isSelected ? UIColor.AppColor.themeColor : UIColor.white
        sender.setTitleColor(sender.isSelected ? UIColor.white : UIColor.black, for: .normal)
        sender.setTitleColor(sender.isSelected ? UIColor.white : UIColor.black, for: .selected)
    }
    
    @IBAction func btnFilterByDatePressed(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        sender.backgroundColor = sender.isSelected ? UIColor.AppColor.themeColor : UIColor.white
        sender.setTitleColor(sender.isSelected ? UIColor.white : UIColor.black, for: .normal)
        sender.setTitleColor(sender.isSelected ? UIColor.white : UIColor.black, for: .selected)
    }
}

//MARK: - COLLECTIONVIEW DELEGATES METHODS
extension SportsFilterVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UICollectionView.contentSize),
           let contentSize = change?[NSKeyValueChangeKey.newKey] as? CGSize {
            
            nslcCollectionHeight.constant = contentSize.height
            nslcSubCatHeight.constant = contentSize.height
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath) as! CityCell
        cell.lblCityName.text = sportsArr[indexPath.item]
        cell.isSelected = indexPath.item == (collectionView == self.collectionView ? selectedIndex : selectedSubCategory)
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width-32)/2
        return CGSize(width: width-10, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            selectedIndex = indexPath.item
        }
        else{
            selectedSubCategory = indexPath.item
        }
        collectionView.reloadData()
    }
}
