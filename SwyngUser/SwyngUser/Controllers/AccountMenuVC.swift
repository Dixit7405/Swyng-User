//
//  AccountMenuVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 27/04/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "EventMenuFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "EventMenuFooter")
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        view.layoutIfNeeded()
        
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
}

//MARK: - CUSTOM DATA
extension AccountMenuVC{
    func setupCollectionView(){
        let dataSource = RxCollectionViewSectionedReloadDataSource<EventMenuSectionData>(
          configureCell: { dataSource, collectionView, indexPath, item in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountMenuCell", for: indexPath) as! AccountMenuCell
            cell.titleLabel.text = item
            return cell
            
          }) { (datasource, collectionView, item, indexPath) -> UICollectionReusableView in
            
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "EventMenuFooter", for: indexPath) as! EventMenuFooter
            return cell
            
        }

        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let sections = [
            EventMenuSectionData(items: arrOptions)
        ]

        Observable.just(sections)
          .bind(to: collectionView.rx.items(dataSource: dataSource))
          .disposed(by: disposeBag)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width-20)/2, height: 80)
        flowLayout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 350)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        view.layoutIfNeeded()
    }
}



//MARK: - ACTION METHOD
extension AccountMenuVC{
    @IBAction func btnBackPressed(_ sender:UIButton){
        self.dismissLeft()
    }
}

//MARK: - COLLECTION DELEGATE
extension AccountMenuVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc:CMSVC = CMSVC.controller()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
