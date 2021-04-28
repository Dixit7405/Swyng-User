//
//  AccountMenuVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 27/04/21.
//

import UIKit

class AccountMenuVC: UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!
    
    var arrOptions = ["Home",
                      "Account Info",
                      "Sports Centers",
                      "Bookings",
                      "Bulk Bookings",
                      "Sports Tournaments",
                      "Tournament\nRegistrations",
                      "Runs",
                      "Run\nRegistrations",
                      "Cancelation & Rescheduling Rules",
                      "Payments Policy",
                      "About SWYNG",
                      "Partner with SWYNG",
                      "Terms of use",
                      "Privacy Policy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "EventMenuFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "EventMenuFooter")
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        view.layoutIfNeeded()
        // Do any additional setup after loading the view.
    }

}

//MARK: - ACTION METHOD
extension AccountMenuVC{
    @IBAction func btnBackPressed(_ sender:UIButton){
        self.dismissLeft()
    }
}

//MARK: - COLLECTION DELEGATE
extension AccountMenuVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountMenuCell", for: indexPath) as! AccountMenuCell
        cell.titleLabel.text = arrOptions[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width-20)/2, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc:CMSVC = CMSVC.controller()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            fatalError()
        case UICollectionView.elementKindSectionFooter:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "EventMenuFooter", for: indexPath) as! EventMenuFooter
            return cell
        default:
            fatalError()
        }
    }
}
