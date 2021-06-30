//
//  TournamentRegisterVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 11/05/21.
//

import UIKit
import AppInvokeSDK

class TournamentRegisterVC: BaseVC {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var nslcTableHeight:NSLayoutConstraint!
    @IBOutlet var bottomViews:[UIView]!
    @IBOutlet weak var lblTerms:UILabel!
    @IBOutlet weak var lblFees:UILabel!
    @IBOutlet weak var lblGST:UILabel!
    @IBOutlet weak var lblTotal:UILabel!
    @IBOutlet weak var lblSlots:UILabel!
    @IBOutlet weak var lblRegisterFees:UILabel!
    @IBOutlet weak var btnAcceptTerms:SelectableButton!
    @IBOutlet weak var registerView:UIView!
    var selectedIndex:[Int] = []
    var myTournaments:[TournamentTicket?] = []
    var myRuns:[RunsTicket?] = []
    
    //MARK: Private Properties
    private let appInvoke = AIHandler()
    private var orderId: String = ""
    private var merchantId: String = ""
    private var txnToken: String = ""
    private var signature: String = ""
    private var amount : String = "0"
    private var callBackURL : String = ""
    private var makeSubscriptionPayment : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomViews.forEach({$0.isHidden = true})
        tableView.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        registerView.backgroundColor = UIColor.lightGray
        lblTerms.text = isTournament ? selectedTournament?.termsAndCondition : selectedRun?.termsAndCondition
        lblSlots.text = String(format: "%d Slots", selectedIndex.count)
        lblRegisterFees.text = String(format: "Rs. %.2f", 0)
        
        // Do any additional setup after loading the view.
    }
}

//MARK: - CUSTOM METHODS
extension TournamentRegisterVC{
    fileprivate func setFeesData(){
        if isTournament{
            myTournaments = []
            for index in 0..<(selectedTournament?.tblTournamentRegistrationTickets ?? []).count{
                if selectedIndex.contains(index){
                    myTournaments.append(selectedTournament?.tblTournamentRegistrationTickets?[index])
                }
            }
            bottomViews.forEach({$0.isHidden = selectedIndex.count == 0})
            let fees = myTournaments.compactMap({Double($0?.participationFees ?? "0")}).reduce(0, +)
            let GST:Double = 0
            lblFees.text = String(format: "Rs. %.1f", fees)
            lblGST.text = String(format: "Rs. %.1f", GST)
            lblTotal.text = String(format: "Rs. %.1f", fees+GST)
            lblSlots.text = String(format: "%d Slots", selectedIndex.count)
            lblRegisterFees.text = String(format: "Rs. %.1f", fees+GST)
            amount = (fees+GST).toString()
        }
        else{
            myRuns = []
            for index in 0..<(selectedRun?.tblRunRegistrationTickets ?? []).count{
                if selectedIndex.contains(index){
                    myRuns.append(selectedRun?.tblRunRegistrationTickets?[index])
                }
            }
            bottomViews.forEach({$0.isHidden = selectedIndex.count == 0})
            let fees = myRuns.compactMap({Double($0?.participationFees ?? "0")}).reduce(0, +)
            let GST:Double = 0
            lblFees.text = String(format: "Rs. %.1f", fees)
            lblGST.text = String(format: "Rs. %.1f", GST)
            lblTotal.text = String(format: "Rs. %.1f", fees+GST)
            lblSlots.text = String(format: "%d Slots", selectedIndex.count)
            lblRegisterFees.text = String(format: "Rs. %.1f", fees+GST)
            amount = (fees+GST).toString()
        }
        registerView.backgroundColor = selectedIndex.count == 0 ? .lightGray : UIColor.AppColor.themeColor
    }
    
    func makePayment(){
        /*
         Staging Environment: https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=<order_id>
         Production Environment: https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=<order_id>
         */
        let merchantKey = "eexh&2_jPK4Bl#SI"
        self.merchantId = "Gybsho21591617362759"
        
        self.callBackURL = "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=\(self.orderId)"
        
        self.appInvoke.openPaytm(merchantId: self.merchantId, orderId: self.orderId, txnToken: self.txnToken, amount: self.amount, callbackUrl:self.callBackURL, delegate: self, environment: AIEnvironment.staging)
    }
    
    func random(digits:Int) -> String {
        var number = String()
        for _ in 1...digits {
           number += "\(Int.random(in: 1...9))"
        }
        return number
    }
}

//MARK: - ACTION METHODS
extension TournamentRegisterVC{
    @IBAction func btnRegisterPressed(_ sender:UIButton){
        if selectedIndex.count == 0{
            return
        }
        self.orderId = random(digits: 6)
        isTournament ? initiateTournamentTransaction() : initiateRunsTransaction()
    }
}

// MARK: - AIDelegate
extension TournamentRegisterVC: AIDelegate {
    func didFinish(with status: AIPaymentStatus, response: [String : Any]) {
        print("🔶 Paytm Callback Response: ", response)
        let alert = UIAlertController(title: "\(status)", message: String(describing: response), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { ok in
            if status == .success{
                if self.isTournament{
                    self.registerData()
                }
                else{
                    self.runsRegisterData()
                }
            }
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openPaymentWebVC(_ controller: UIViewController?) {
        if let vc = controller {
            DispatchQueue.main.async {[weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
        self.dismiss(animated: true)
    }
}

//MARK: - TABLEVIEW DELEGATE
extension TournamentRegisterVC:UITableViewDelegate, UITableViewDataSource{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcTableHeight.constant = tableView.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isTournament ? selectedTournament?.tblTournamentRegistrationTickets?.count : selectedRun?.tblRunRegistrationTickets?.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TournamentRegisterCell", for: indexPath) as! TournamentRegisterCell
        if isTournament{
            cell.tournamentTicket = selectedTournament?.tblTournamentRegistrationTickets?[indexPath.row]
        }
        else{
            cell.runsTicket = selectedRun?.tblRunRegistrationTickets?[indexPath.row]
        }
        cell.btnSelection.isSelected = selectedIndex.contains(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex.contains(indexPath.row){
            let index = selectedIndex.firstIndex(where: {$0 == indexPath.row}) ?? 0
            selectedIndex.remove(at: index)
        }
        else{
            selectedIndex.append(indexPath.row)
        }
        setFeesData()
        tableView.reloadData()
    }
}

//MARK: - API SERVICES
extension TournamentRegisterVC{
    private func initiateTournamentTransaction(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.tournament_id:selectedTournament?.tournamentId ?? "",
                                   Parameters.amount:Double(amount) ?? 0,
                                   Parameters.orderId:orderId]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.initTournamentTransaction, type: CommonResponse<InitTransaction>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<InitTransaction> else {return}
            txnToken = response.data?.body?.txnToken ?? ""
            signature = response.data?.head?.signature ?? ""
            makePayment()
        }
    }
    
    private func initiateRunsTransaction(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.run_id:selectedRun?.id ?? 0,
                                   Parameters.amount:Double(amount) ?? 0,
                                   Parameters.orderId:orderId]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.initRunsTransaction, type: CommonResponse<InitTransaction>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<InitTransaction> else {return}
            txnToken = response.data?.body?.txnToken ?? ""
            signature = response.data?.head?.signature ?? ""
            makePayment()
        }
    }
    
    private func registerData(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.amount:Double(amount) ?? 0,
                                   Parameters.tournament_id:selectedTournament?.tournamentId ?? 0,
                                   Parameters.signature:signature,
                                   Parameters.txnToken:txnToken,
                                   Parameters.booking_id:orderId,
                                   Parameters.ticket_id:myTournaments.compactMap({$0?.id}),
                                   Parameters.orderId:orderId]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.tournamentRegistration, type: TournamentRegister.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let _ = success as? TournamentRegister else {return}
            showAlertWith(message: "Booking Successful", isConfirmation: false, okTitle: "Ok", cancelTitle: "") {
                self.navigationController?.popViewController(animated: true)
            } cancelPressed: {
                print("")
            }

        }
    }
    
    private func runsRegisterData(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.amount:Double(amount) ?? 0,
                                   Parameters.run_id:selectedRun?.id ?? 0,
                                   Parameters.signature:signature,
                                   Parameters.txnToken:txnToken,
                                   Parameters.booking_id:orderId,
                                   Parameters.ticket_id:myRuns.compactMap({$0?.id}),
                                   Parameters.orderId:orderId]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.runsRegistration, type: CommonResponse<RunRegister>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let _ = success as? CommonResponse<RunRegister> else {return}
            showAlertWith(message: "Booking Successful", isConfirmation: false, okTitle: "Ok", cancelTitle: "") {
                self.navigationController?.popViewController(animated: true)
            } cancelPressed: {
                print("")
            }

        }
    }
}
