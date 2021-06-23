//
//  TournamentCMSVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 12/05/21.
//

import UIKit
import WebKit

class TournamentCMSVC: BaseVC {
    @IBOutlet weak var viewWebContainer:UIView!
    @IBOutlet weak var viewUploadFiles:UIView!
    @IBOutlet weak var lblUploadTime:UILabel!
    @IBOutlet weak var lblUploadType:UILabel!
    @IBOutlet weak var btnUpload:UIButton!
    
    enum PageType {
        case fixture
        case results
        case gallery
        case published
    }
    
    var pageType:PageType = .fixture
    var tournament:Tournaments?{
        get{
            return ApplicationManager.tournament
        }
    }
    
    var runs:Run?{
        get{
            return ApplicationManager.runs
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        var fileString:String?
        let time = (isTournament ? ApplicationManager.tournament?.registerBeforeFromStartTime : ApplicationManager.runs?.registerBeforeFromStartTime) ?? ""
        let name = (isTournament ? ApplicationManager.tournament?.tournamentName : ApplicationManager.runs?.runName) ?? ""
        switch pageType {
        case .fixture:
            headerView.lblHeader.text = "\(name) Fixtures & Schedule"
            lblUploadTime.text = """
                                Please upload the fixtures & schedule by
                                \(time).
                                Thank you!
                                """
            lblUploadType.text = "Upload A PDF Document Only"
            btnUpload.setTitle("Upload Fixtures & Schedule", for: .normal)
            fileString = isTournament ? tournament?.fixerAndSchedulePdf : runs?.fixerAndSchedulePdf
        case .results:
            headerView.lblHeader.text = "\(name) Results"
            lblUploadTime.text = """
                                Please upload the results by
                                \(time).
                                Thank you!
                                """
            lblUploadType.text = "Upload A PDF Document Only"
            btnUpload.setTitle("Upload Results", for: .normal)
            fileString = isTournament ? tournament?.tournamentResult : runs?.runResult
        case .gallery:
            headerView.lblHeader.text = "\(name) Photo Gallery"
            lblUploadTime.text = ""
            lblUploadType.text = "Upload .png or .jpeg images Only"
            btnUpload.setTitle("Upload Photos", for: .normal)
            fileString = isTournament ? tournament?.galleryImage : runs?.galleryImage
        case .published:
            headerView.lblHeader.text = "\(name) Published"
            lblUploadTime.text = """
                                Please upload the published by
                                \(time).
                                Thank you!
                                """
            lblUploadType.text = "Upload A PDF Document Only"
            btnUpload.setTitle("Upload Results", for: .normal)
            fileString = isTournament ? tournament?.tournamentPublished : runs?.runPublished
        }
        if let fileString = fileString{
            viewUploadFiles.isHidden = true
            viewWebContainer.isHidden = false
            if pageType == .gallery{
                let imageView = UIImageView()
                viewWebContainer.addSubview(imageView)
                imageView.snp.makeConstraints({
                    $0.edges.equalToSuperview()
                })
                imageView.setImage(from: fileString)
                return
            }
            let webView = WKWebView()
            viewWebContainer.addSubview(webView)
            webView.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })
            if let url = URL(string: fileString){
                webView.load(URLRequest(url: url))
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnUploadPressed(_ sender:UIButton){
        if pageType == .gallery{
            self.showMediaPickerOptions(vc: self)
        }
        else{
            self.openPDFPicker(vc: self)
        }
    }
}
