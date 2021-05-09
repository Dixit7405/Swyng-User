//
//  BookingListVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 08/05/21.
//

import UIKit

class BookingListVC: UIViewController {
    @IBOutlet weak var lblSelectedTab:UILabel!
    @IBOutlet weak var lblNonSelectedTab:UILabel!
    
    var isUpcoming = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: - ACTION METHODS
extension BookingListVC{
    @IBAction func btnSwitchTab(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        isUpcoming = !sender.isSelected
        if sender.isSelected{
            lblSelectedTab.text = "Past Bookings"
            lblNonSelectedTab.text = "Upcomming Bookings"
        }
        else{
            lblNonSelectedTab.text = "Past Bookings"
            lblSelectedTab.text = "Upcomming Bookings"
        }
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - TABLEVIEW DELEGATES
extension BookingListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingCourtBookingCell", for: indexPath) as! UpcommingCourtBookingCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:BookingReviewVC = BookingReviewVC.controller()
        vc.pageType = isUpcoming ? .upcoming : .past
        navigationController?.pushViewController(vc, animated: true)
    }
}
