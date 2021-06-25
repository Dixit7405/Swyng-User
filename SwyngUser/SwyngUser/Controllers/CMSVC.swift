//
//  CMSVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 28/04/21.
//

import UIKit
import RxSwift
import RxCocoa

class CMSVC: UIViewController {
    @IBOutlet weak var lblPageTitle:UILabel!
    @IBOutlet weak var txtvContent:UITextView!
    @IBOutlet weak var imgHeader:UIImageView!
    
    
    let disposeBag = DisposeBag()
    var viewModel = CMSViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.type
          .asObservable()
            .map { $0.rawValue }
          .bind(to:self.lblPageTitle.rx.text)
          .disposed(by:self.disposeBag)
        
        viewModel.image.asObservable()
            .map({UIImage(named: $0.rawValue)})
            .bind(to: imgHeader.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.alert.subscribe { alert in
            self.showAlertWith(message: alert)
        }.disposed(by: disposeBag)
        
        viewModel.content.asObservable().bind(to: txtvContent.rx.text).disposed(by: disposeBag)
        
        startActivityIndicator()
        viewModel.getCMSPageData { [weak self] in
            self?.stopActivityIndicator()
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        dismiss(animated: true, completion: nil)
    }

}
