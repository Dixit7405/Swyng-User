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
    @IBOutlet weak var btnCancelReschedule:UIButton!
    @IBOutlet weak var lblPleaseNote:UILabel!
    @IBOutlet weak var lblOrganizerTC:UILabel!
    @IBOutlet weak var clctnBanners:UICollectionView!
    @IBOutlet weak var pageControlBanner:UIPageControl!
    @IBOutlet weak var lblOrganizerHeading:UILabel!
    @IBOutlet weak var lblCancelBooking:UILabel!
    @IBOutlet weak var headerView:HeaderView!
    @IBOutlet weak var cancelationRuleStack:UIStackView!
    
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
    var tournaments:[Tournaments] = []
    var runs:[Run] = []
    var arrCategories:[TournamentsType] = []
    var arrRunsCategories:[RunsCategory] = []
    var confirmedArr:[CancelTicket]{
        get{
            var arr:[CancelTicket] = []
            tournamentData?.tickets?.forEach({
                if !arr.compactMap({$0.ticketId}).contains($0.ticketId){
                    arr.append($0)
                }
            })
            return arr
        }
    }
    var cancelledArr:[CancelTicket]{
        get{
            var arr:[CancelTicket] = []
            tournamentData?.cancelTickets?.forEach({
                if !arr.compactMap({$0.ticketId}).contains($0.ticketId){
                    arr.append($0)
                }
            })
            return arr
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.backBlock = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        headerView.menuBlock = { [weak self] in
            self?.btnMenuPressed(self?.headerView.btnMenu ?? UIButton())
        }
        tableView.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        /*if pageType == .review{
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
        else */if pageType == .upcoming{
            viewAvailableOnRent.isHidden = true
            viewAvailableForSale.isHidden = true
            stackNeedHelp.isHidden = true
            viewCenterGuidelines.isHidden = true
            viewBanners.isHidden = true
            viewCancel.isHidden = true
            viewReschedule.isHidden = true
            headerView.isHidden = true
        }
        else if pageType == .confirmed{
            stackFees.isHidden = true
            stackCancelCharges.isHidden = true
            viewReschedule.isHidden = true
            btnCancelReschedule.isHidden = true
            viewCenterGuidelines.isHidden = true
            viewCancelButtons.isHidden = true
            headerView.isHidden = false
        }
        setupCancelFees()
        tournamentId != nil ? getRegistrationData() : getRunsRegistrationData()
        tournamentId != nil ? getTournamentCategories() : getRunsCategories()
        // Do any additional setup after loading the view.
    }
    
    func setupPageData(){
        guard let data = tournamentData else {return}
        lblHeader.text = tournamentId != nil ? tournamentName : runName
        
        lblBookingId.text = String(format: "Booking Id: %@", data.bookingId ?? "")
        
        if ApplicationManager.sportType == .tournaments{
            lblPleaseNote.text = data.tournament?.pleaseNote
            lblOrganizerTC.text = data.tournament?.aboutOrganizer
            lblAddress.text = data.tournament?.venueAddress
            lblCancelBooking.text = String(format: "You can cancel this booking before %@", ApplicationManager.tournament?.registerBeforeFromStartTime ?? "")
        }
        else{
            lblPleaseNote.text = data.run?.pleaseNote
            lblOrganizerHeading.text = "Route Map"
            lblOrganizerTC.text = data.run?.routeMap
            let address = String(format:"%@\n%@\n%@",(data.run?.venue ?? ""), (data.run?.address ?? ""), (data.run?.city ?? ""))
            lblAddress.text = address
            lblCancelBooking.text = String(format: "You can cancel this booking before %@", ApplicationManager.runs?.registerBeforeFromStartTime ?? "")
        }
        
//        cancelationRuleStack.arrangedSubviews.forEach({$0.removeFromSuperview()})
        for rule in data.cancelationRules ?? []{
            let lastDate = data.tournament?.dates?.last?.convertDate(format: .serverDate) ?? Date()
            var beforeDate:Date?
            var afterDate:Date?
            let dateFormat = "hh.mm a EEE dd MMM yyyy"
            if rule.time?.contains("+") ?? false{
                let afterValue = rule.time?.replacingOccurrences(of: "+", with: "").doubleValue
                afterDate = lastDate.addingTimeInterval(-((afterValue ?? 0)*3600))
            }
            else if rule.time?.contains("-") ?? false{
                let split = rule.time?.split(separator: "-")
                let before = split?.first
                let after = split?.last
                beforeDate = lastDate.addingTimeInterval(-((Double(before ?? "0") ?? 0)*3600))
                afterDate = lastDate.addingTimeInterval(-((Double(after ?? "0") ?? 0)*3600))
            }
            if beforeDate == nil, afterDate != nil{
                let ruleView = CancelationRuleView()
                let afterD = afterDate?.toDate(format: dateFormat) ?? ""
                ruleView.lblRule.text = String(format: "Cancelation before %@", afterD)
                ruleView.lblPercentage.text = String(format: "%@ %%", rule.age ?? "0")
                cancelationRuleStack.addArrangedSubview(ruleView)
            }
            else if beforeDate != nil, afterDate != nil{
                let ruleView = CancelationRuleView()
                let afterD = afterDate?.toDate(format: dateFormat) ?? ""
                let beforeD = beforeDate?.toDate(format: dateFormat) ?? ""
                ruleView.lblRule.text = String(format: "Cancel after %@ & before %@", afterD, beforeD)
                ruleView.lblPercentage.text = String(format: "%@ %%", rule.age ?? "")
                cancelationRuleStack.addArrangedSubview(ruleView)
            }
        }
        
        tableView.reloadData()
    }

    func setupCancelFees(){
        stackFees.isHidden = selectedTickets.count == 0
        viewCancelButtons.isHidden = selectedTickets.count == 0
        var selectedTournaments:[CancelTicket] = []
        if tournamentId != nil{
            selectedTournaments = tournamentData?.tickets?.filter({selectedTickets.contains($0.ticketId ?? 0)}) ?? []
        }
        else{
            
            for ticket in selectedTickets{
                if let tickt = tournamentData?.tickets?.first(where: {$0.ticketId == ticket}){
                    selectedTournaments.append(tickt)
                }
            }
        }
        let fees = selectedTournaments.compactMap({Double($0.category?.amount ?? "0")}).reduce(0, +)
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
        showAlertWith(message: "Are you sure you want to cancel this booking?", isConfirmation: true, okTitle: "Yes", cancelTitle: "No") { [self] in
            tournamentId != nil ? cancelRegistrationData() : cancelRunsRegistrationData()
        } cancelPressed: {
            
        }

        
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDirectionTapped(_ sender:UIButton){
        if tournamentId != nil{
            guard let urlString = tournamentData?.tournament?.venueGoogleMap, let url = URL(string: urlString) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else{
            guard let urlString = tournamentData?.run?.venueGoogleMap, let url = URL(string: urlString) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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
        if tournamentId != nil{
            let ticket = tournamentData?.tickets?.count ?? 0
            let cancelTicket = tournamentData?.cancelTickets?.count ?? 0
            return ticket + cancelTicket
        }
        if pageType == .upcoming{
            return confirmedArr.count
        }
        return confirmedArr.count + cancelledArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tournamentId != nil{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingReviewCell", for: indexPath) as! BookingReviewCell
            cell.btnClose.isHidden = pageType == .past
            
            
            if pageType == .upcoming{
                cell.btnClose.setImage(#imageLiteral(resourceName: "radio_empty"), for: .normal)
                cell.btnClose.setImage(#imageLiteral(resourceName: "confirm_red 5"), for: .selected)
            }
            else if pageType == .confirmed{
                cell.btnClose.setImage(nil, for: .normal)
                cell.btnClose.setImage(#imageLiteral(resourceName: "cancel_red"), for: .selected)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunCell", for: indexPath) as! BookingReviewCell
        if indexPath.item < confirmedArr.count{
            let ticket = confirmedArr[indexPath.row]
            let max = tournamentData?.tickets?.filter({ticket.ticketId == $0.ticketId}).count ?? 0
            cell.stepperView.maxValue = max
            let selected = selectedTickets.filter({$0 == ticket.ticketId}).count
            cell.stepperView.currentIndex = max - selected
            cell.stepperUpdateBlock = {[self] index in
                let total = max - index
                selectedTickets.removeAll(where: {$0 == ticket.ticketId})
                let selectedArr = Array(repeating: ticket.ticketId ?? 0, count: total)
                selectedTickets.append(contentsOf: selectedArr)
                setupCancelFees()
            }
            cell.stepperView.btnPlus.isHidden = pageType == .confirmed
            cell.stepperView.btnMinus.isHidden = pageType == .confirmed
            cell.ticket = ticket
            cell.btnClose.isHidden = true
        }
        else{
            let cancelTicket = cancelledArr[indexPath.row - confirmedArr.count]
            let max = tournamentData?.cancelTickets?.filter({cancelTicket.ticketId == $0.ticketId}).count ?? 0
            cell.stepperView.btnPlus.isHidden = true
            cell.stepperView.btnMinus.isHidden = true
            cell.stepperView.currentIndex = max
            cell.ticket = cancelTicket
            cell.btnClose.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if pageType == .confirmed || tournamentId == nil{
            return
        }
        var ticket:CancelTicket?
        if indexPath.row < tournamentData?.tickets?.count ?? 0{
            ticket = tournamentData?.tickets?[indexPath.row]
            
        }
        else{
            let allTicket = tournamentData?.tickets?.count ?? 0
            ticket = tournamentData?.cancelTickets?[indexPath.row - allTicket]
            return
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
        return tournamentId != nil ? tournaments.count : runs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCell", for: indexPath) as! HomeBannerCell
        if tournamentId != nil{
            cell.categories = arrCategories
            cell.tournament = tournaments[indexPath.item]
        }
        else{
            cell.runsCategories = arrRunsCategories
            cell.runs = runs[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*let vc:TournamentDetailsVC = TournamentDetailsVC.controller()
        if tournamentId != nil{
            vc.tournament = tournaments[indexPath.row]
            ApplicationManager.tournament = tournaments[indexPath.row]
        }
        else{
            ApplicationManager.runs = runs[indexPath.row]
            vc.runs = runs[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)*/
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
            if response.success == true{
                let vc:CancelledVC = .controller()
                vc.delegate = self
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }

        }
    }
    
    private func cancelRunsRegistrationData(){
        var selectedTickets = self.selectedTickets
        var remain = tournamentData?.tickets?.compactMap({$0.ticketId}) ?? []
        
        selectedTickets.append(contentsOf: tournamentData?.cancelTickets?.compactMap({$0.ticketId}) ?? [])
        for ticket in selectedTickets{
            if remain.contains(ticket){
                if let index = remain.firstIndex(of: ticket){
                    remain.remove(at: index)
                }
            }
        }
        
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.run_id:runId ?? 0,
                                   Parameters.cancel_category_id:[],
                                   Parameters.txnToken:tournamentData?.tickets?.compactMap({$0.txnToken}).first ?? "",
                                   Parameters.refund_amount:refundAmount,
                                   Parameters.remain_ticket_id:remain
        ]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.cancelRunsTicket, type: CommonResponse<CancelTicketResponse>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<CancelTicketResponse> else {return}
            if response.success == true{
                let vc:CancelledVC = .controller()
                vc.delegate = self
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    private func getAllTournaments(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getUpPastTournaments + "upcoming", type: CommonResponse<[Tournaments]>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<[Tournaments]> else {return}
            if let data = self.successBlock(response: response){
                self.tournaments = data
                self.clctnBanners.reloadData()
                self.pageControlBanner.numberOfPages = data.count
            }
        }
    }
    
    private func getUpcomingRuns(){
        let endPoint = EndPoints.getUpPastRuns + "upcoming"
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        self.startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: endPoint, type: CommonResponse<[Run]>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<[Run]>, let data = self.successBlock(response: response){
                self.runs = data
                self.clctnBanners.reloadData()
                self.pageControlBanner.numberOfPages = data.count
            }
        }
    }
    
    private func getTournamentCategories(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .get, endPoint: EndPoints.getTournamentTypes, type: CommonResponse<[TournamentsType]>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<[TournamentsType]> else {return}
            if let data = self.successBlock(response: response){
                self.arrCategories = data
                self.getAllTournaments()
            }
        }
    }
    
    private func getRunsCategories(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .get, endPoint: EndPoints.getRunsCategory, type: CommonResponse<[RunsCategory]>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<[RunsCategory]> else {return}
            if let data = self.successBlock(response: response){
                self.arrRunsCategories = data
                self.getUpcomingRuns()
            }
        }
    }
}

//MARK: - CANCELLED DELEGATE
extension BookingReviewVC:CancelledDelegate{
    func didDismissVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
