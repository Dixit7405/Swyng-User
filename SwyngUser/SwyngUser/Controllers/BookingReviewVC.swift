//
//  BookingReviewVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 07/05/21.
//

import UIKit

class BookingReviewVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var nslcTableHeight:NSLayoutConstraint!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var viewBookingId:UIView!
    @IBOutlet weak var stackCancelBooking:UIStackView!
    @IBOutlet weak var viewCancel:UIView!
    @IBOutlet weak var viewReschedule:UIView!
    @IBOutlet weak var viewAvailableOnRent:UIView!
    @IBOutlet weak var viewAvailableForSale:UIView!
    @IBOutlet weak var stackNeedHelp:UIStackView!
    @IBOutlet weak var viewBanners:UIView!
    @IBOutlet weak var viewCenterGuidelines:UIView!
    @IBOutlet weak var stackCancelCharges:UIStackView!
    @IBOutlet weak var stackFees:UIStackView!
    @IBOutlet weak var stackAddress:UIStackView!
    @IBOutlet weak var lblBookingId:UILabel!
    @IBOutlet weak var lblParticipationFees:UILabel!
    @IBOutlet weak var lblGST:UILabel!
    @IBOutlet weak var lblCancelationCharge:UILabel!
    @IBOutlet weak var lblBalance:UILabel!
    @IBOutlet weak var lblAddress:UILabel!
    @IBOutlet weak var lblRefundAmount:UILabel!
    @IBOutlet weak var viewCancelButtons:UIView!
    @IBOutlet weak var lblHeader:UILabel!
    @IBOutlet weak var imgHeader:UIImageView!
    
    enum PageType {
        case review
        case confirmed
        case upcoming
        case past
    }
    
    var pageType:PageType = .review
    var tournamentId:Int?
    var tournamentName:String?
    var runId:Int?
    var runName:String?
    var tournamentData:TournamentRegistrationData?
    var selectedTickets:[Int] = []
    var refundAmount:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        if pageType == .review{
            viewBookingId.isHidden = true
            stackCancelBooking.isHidden = true
            viewAvailableOnRent.isHidden = true
            viewAvailableForSale.isHidden = true
            stackNeedHelp.isHidden = true
            viewBanners.isHidden = true
            stackCancelCharges.isHidden = true
        }
        else if pageType == .past{
            stackCancelBooking.isHidden = true
            viewAvailableOnRent.isHidden = true
            viewAvailableForSale.isHidden = true
            stackNeedHelp.isHidden = true
            viewCenterGuidelines.isHidden = true
            stackCancelCharges.isHidden = true
        }
        else if pageType == .upcoming{
            viewAvailableOnRent.isHidden = true
            viewAvailableForSale.isHidden = true
            stackNeedHelp.isHidden = true
            viewCenterGuidelines.isHidden = true
            viewBanners.isHidden = true
            viewCancel.isHidden = true
            viewReschedule.isHidden = true
        }
        setupCancelFees()
        tournamentId != nil ? getRegistrationData() : getRunsRegistrationData()
        // Do any additional setup after loading the view.
    }
    
    func setupPageData(){
        guard let data = tournamentData else {return}
        lblHeader.text = tournamentId != nil ? tournamentName : runName
        
        lblBookingId.text = String(format: "Booking Id: %@", data.bookingId ?? "")
        lblAddress.text = data.tournament?.venueAddress
        
        tableView.reloadData()
    }

    func setupCancelFees(){
        stackFees.isHidden = selectedTickets.count == 0
        viewCancelButtons.isHidden = selectedTickets.count == 0
        let selectedTournaments = tournamentData?.tickets?.filter({selectedTickets.contains($0.ticketId ?? 0)})
        let fees = selectedTournaments?.compactMap({Double($0.category?.amount ?? "0")}).reduce(0, +) ?? 0
        let gst:Double = 0
        let cancelationCharge:Double = 0
        refundAmount = fees+gst-cancelationCharge
        lblParticipationFees.text = String(format: "Rs. %.0f", fees)
        lblGST.text = String(format: "Rs. %.0f", gst)
        lblCancelationCharge.text = String(format: "Rs. %.0f", cancelationCharge)
        lblBalance.text = String(format: "Rs. %.0f", refundAmount)
        lblRefundAmount.text = String(format: "Rs. %.0f", refundAmount)
    }
}

//MARK: - ACTION METHODS
extension BookingReviewVC{
    @IBAction func btnNextPressed(_ sender:UIButton){
        tournamentId != nil ? cancelRegistrationData() : cancelRunsRegistrationData()
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDirectionTapped(_ sender:UIButton){
        guard let urlString = tournamentData?.tournament?.venueGoogleMap, let url = URL(string: urlString) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func btnCancelationRules(_ sender:UIButton){
        let vc:CMSVC = .controller()
        let vm = CMSViewModel()
        vm.type.accept(.cancellationRules)
        vm.image.accept(.cancellationRules)
        vc.viewModel = vm
        present(vc, animated: true, completion: nil)
    }
}


//MARK: - TABLEVIEW DELEGATES
extension BookingReviewVC:UITableViewDelegate,UITableViewDataSource{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcTableHeight.constant = tableView.contentSize.height
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ticket = tournamentData?.tickets?.count ?? 0
        let cancelTicket = tournamentData?.cancelTickets?.count ?? 0
        return ticket + cancelTicket
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingReviewCell", for: indexPath) as! BookingReviewCell
        cell.btnClose.isHidden = pageType == .past
        
        
        if pageType == .upcoming{
            cell.btnClose.setImage(#imageLiteral(resourceName: "radio_empty"), for: .normal)
            cell.btnClose.setImage(#imageLiteral(resourceName: "confirm_red 5"), for: .selected)
        }
        else{
            cell.btnClose.setImage(#imageLiteral(resourceName: "close"), for: .normal)
            cell.btnClose.setImage(#imageLiteral(resourceName: "close"), for: .selected)
        }
        if indexPath.item < tournamentData?.tickets?.count ?? 0{
            let ticket = tournamentData?.tickets?[indexPath.row]
            cell.setSelected = selectedTickets.contains(ticket?.ticketId ?? 0)
            cell.ticket = ticket
            
        }
        else{
            let ticket = tournamentData?.tickets?.count ?? 0
            let cancelTicket = tournamentData?.cancelTickets?[indexPath.row - ticket]
            cell.setSelected = true
            cell.ticket = cancelTicket
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var ticket:CancelTicket?
        if indexPath.row < tournamentData?.tickets?.count ?? 0{
            ticket = tournamentData?.tickets?[indexPath.row]
            
        }
        else{
            let allTicket = tournamentData?.tickets?.count ?? 0
            ticket = tournamentData?.cancelTickets?[indexPath.row - allTicket]
            
        }
        if selectedTickets.contains(ticket?.ticketId ?? 0){
            selectedTickets.removeAll(where: {$0 == ticket?.ticketId ?? 0})
        }
        else{
            selectedTickets.append(ticket?.ticketId ?? 0)
        }
        tableView.reloadData()
        setupCancelFees()
    }
}

//MARK: - COLLECTIONVIEW DELEGATES
extension BookingReviewVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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


//MARK: - API SERVICES
extension BookingReviewVC{
    private func getRegistrationData(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.tournament_id:tournamentId ?? 0]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.tournamentRegistrationData, type: CommonResponse<TournamentRegistrationData>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<TournamentRegistrationData> else {return}
            if let data = successBlock(response: response){
                tournamentData = data
                setupPageData()
                
            }
        }
        
    }
    
    private func getRunsRegistrationData(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.run_id:runId ?? 0]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.runRegistrationData, type: CommonResponse<TournamentRegistrationData>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<TournamentRegistrationData> else {return}
            if let data = successBlock(response: response){
                tournamentData = data
                setupPageData()
                
            }
        }
        
    }
    
    private func cancelRegistrationData(){
        var selectedTickets = self.selectedTickets
        selectedTickets.append(contentsOf: tournamentData?.cancelTickets?.compactMap({$0.ticketId}) ?? [])
        var remain = tournamentData?.tickets?.compactMap({$0.ticketId}) ?? []
        remain = remain.filter({!selectedTickets.contains($0)})
        
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.tournament_id:tournamentId ?? 0,
                                   Parameters.cancel_category_id:selectedTickets,
                                   Parameters.txnToken:tournamentData?.tickets?.compactMap({$0.txnToken}).first ?? "",
                                   Parameters.refund_amount:refundAmount,
                                   Parameters.remain_ticket_id:remain
        ]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.cancelTicket, type: CommonResponse<CancelTicketResponse>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<CancelTicketResponse> else {return}
            self.showAlertWith(message: response.message ?? "") {
                self.navigationController?.popToRootViewController(animated: true)
            } cancelPressed: {
                print("Nothing")
            }

        }
    }
    
    private func cancelRunsRegistrationData(){
        var selectedTickets = self.selectedTickets
        selectedTickets.append(contentsOf: tournamentData?.cancelTickets?.compactMap({$0.ticketId}) ?? [])
        var remain = tournamentData?.tickets?.compactMap({$0.ticketId}) ?? []
        remain = remain.filter({!selectedTickets.contains($0)})
        
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.run_id:runId ?? 0,
                                   Parameters.cancel_category_id:selectedTickets,
                                   Parameters.txnToken:tournamentData?.tickets?.compactMap({$0.txnToken}).first ?? "",
                                   Parameters.refund_amount:refundAmount,
                                   Parameters.remain_ticket_id:remain
        ]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.cancelRunsTicket, type: CommonResponse<CancelTicketResponse>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<CancelTicketResponse> else {return}
            self.showAlertWith(message: response.message ?? "") {
                self.navigationController?.popToRootViewController(animated: true)
            } cancelPressed: {
                print("Nothing")
            }

        }
    }
}
