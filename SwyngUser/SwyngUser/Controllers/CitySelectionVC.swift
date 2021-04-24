//
//  CitySelectionVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class CitySelectionVC: UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var nslcCollectionHeight:NSLayoutConstraint!
    @IBOutlet weak var viewBg:UIView!
    @IBOutlet weak var btnApplySelection:UIButton!
    
    var citiesArr:[String] = ["Bangaluru",
                              "Chennai",
                              "Delhi",
                              "Hyderabad",
                              "Mumbai",
                              "Pune"]
    var selectedIndex:Int?{
        didSet{
            btnApplySelection.backgroundColor = selectedIndex != nil ? UIColor.AppColor.themeColor : UIColor.white
            btnApplySelection.setTitleColor(selectedIndex != nil ? UIColor.white : UIColor.black, for: .normal)
            btnApplySelection.isUserInteractionEnabled = selectedIndex != nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        collectionView.reloadData()
        selectedIndex = nil
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: [NSKeyValueObservingOptions.new], context: nil)
        viewBg.dropShadow(color: UIColor.black, opacity: 0.5, offSet: CGSize(width: 0.0, height: 15.0), radius: 10.0)
        btnApplySelection.dropShadow(color: UIColor.black, opacity: 0.5)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        viewBg.updateShadowPath()
        btnApplySelection.updateShadowPath()
    }

}

//MARK: - ACTION METHODS
extension CitySelectionVC{
    @IBAction func btnApplySelectionPressed(_ sender:UIButton){
        let vc = UIStoryboard(name: "Dashboard", bundle: nil)
        if let window = AppUtilities.shared().getMainWindow(){
            window.rootViewController = vc.instantiateInitialViewController()
        }
    }
}

//MARK: - ACTION METHODS
extension CitySelectionVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UITextView.contentSize),
           let contentSize = change?[NSKeyValueChangeKey.newKey] as? CGSize {
            print("contentSize:", contentSize)
            nslcCollectionHeight.constant = contentSize.height
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citiesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath) as! CityCell
        cell.lblCityName.text = citiesArr[indexPath.item]
        cell.isSelected = indexPath.item == selectedIndex
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width-32)/2
        return CGSize(width: width-10, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData()
    }
}
