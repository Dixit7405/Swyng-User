//
//  SportsFilterVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 05/05/21.
//

import UIKit

@objc class Filter:NSObject{
    var sport:[Sports] = []
    var category:String?
    var gallery:Bool?
    var filter:Bool?
}

@objc protocol SportsFilterDelegate:AnyObject {
    func didApplyFilter(filter:Filter)
}

class SportsFilterVC: BaseVC {
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var btnApplySelection:UIButton!
    @IBOutlet weak var nslcCollectionHeight:NSLayoutConstraint!
    @IBOutlet weak var btnAllSports:UIButton!
    @IBOutlet weak var collectionSubCategory:UICollectionView!
    @IBOutlet weak var btnListGrid:UIButton!
    @IBOutlet weak var btnByDate:UIButton!
    @IBOutlet weak var nslcSubCatHeight:NSLayoutConstraint!
    @IBOutlet weak var viewSubCategorySeprator:UIView!
    @IBOutlet weak var stackView:UIStackView!
    
    var sportsArr:[Sports] = []
    var selectedIndex:[Int] = []{
        didSet{
            if forSportCenter{
                setApplyEnabled(selectedIndex.count != 0)
            }
            else{
                setApplyEnabled(true)
            }
            
            btnAllSports.backgroundColor = selectedIndex.count == 0 ? UIColor.AppColor.themeColor : UIColor.white
            btnAllSports.setTitleColor(selectedIndex.count == 0 ? UIColor.white : UIColor.black, for: .normal)
        }
    }
    
    var selectedSubCategory:Int?
    var showSubCategory = false
    var forSportCenter = false
    
    weak var delegate:SportsFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        collectionView.reloadData()
        selectedIndex = []
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: [NSKeyValueObservingOptions.new], context: nil)
        
        collectionSubCategory.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionSubCategory.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: [NSKeyValueObservingOptions.new], context: nil)
        
        viewSubCategorySeprator.isHidden = !showSubCategory
        collectionSubCategory.isHidden = !showSubCategory
        
        stackView.isHidden = forSportCenter
        getSportsList()
        // Do any additional setup after loading the view.
    }

}

//MARK: - CUSTOM METHODS
extension SportsFilterVC{
    private func setApplyEnabled(_ enable:Bool){
        btnApplySelection.backgroundColor = enable ? UIColor.AppColor.themeColor : UIColor.white
        btnApplySelection.setTitleColor(enable ? UIColor.white : UIColor.black, for: .normal)
        btnApplySelection.isUserInteractionEnabled = enable
    }
}

//MARK: - ACTION METHODS
extension SportsFilterVC{
    @IBAction func btnApplySelectionPressed(_ sender:UIButton){
        if selectedIndex.count == 0, forSportCenter {
            showAlertWith(message: "Please select sport for apply filter")
            return
        }
        navigationController?.popViewController(animated: true){ [unowned self] in
            let filter = Filter()
            var arr:[Sports] = []
            for i in 0..<sportsArr.count{
                if selectedIndex.contains(i){
                    arr.append(sportsArr[i])
                }
            }
            filter.sport = arr
            filter.gallery = btnListGrid.isSelected
            filter.filter = btnByDate.isSelected
            self.delegate?.didApplyFilter(filter: filter)
        }
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAllSportsPressed(_ sender:UIButton){
        selectedIndex = []
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
        cell.lblCityName.text = sportsArr[indexPath.item].name
        cell.isSelected = selectedIndex.contains(indexPath.item)
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width-32)/2
        return CGSize(width: width-10, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            if selectedIndex.contains(indexPath.item){
                selectedIndex.removeAll(where: {$0 == indexPath.item})
            }
            else{
                selectedIndex.append(indexPath.item)
            }
        }
        else{
            selectedSubCategory = indexPath.item
        }
        collectionView.reloadData()
    }
}

//MARK: - API SERVICES
extension SportsFilterVC{
    private func getSportsList(){
        startActivityIndicator()
        Webservices().request(with: [:], method: .get, endPoint: EndPoints.getAllSports, type: CommonResponse<[Sports]>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<[Sports]>, let data = self.successBlock(response: response){
                self.sportsArr = data
                self.collectionView.reloadData()
            }
        }
    }
}
