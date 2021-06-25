//
//  PartnerWithUsVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 29/04/21.
//

import UIKit

class PartnerWithUsVC: UIViewController {
    @IBOutlet weak var lblContent:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPartnerData()
        // Do any additional setup after loading the view.
    }
    

}

//MARK: - API SERVICES
extension PartnerWithUsVC{
    private func getPartnerData(){
        startActivityIndicator()
        Webservices().request(with: [:], method: .get, endPoint: EndPoints.partnerWithSwyng, type: CommonResponse<[CMSData]>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<[CMSData]> else {return}
            if let data = self.successBlock(response: response){
                self.lblContent.text = data.first?.text
            }
        }
    }
}
