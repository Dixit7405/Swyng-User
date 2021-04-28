//
//  UIViewController+Extension.swift
//  VideoMaker
//
//  Created by Dixit Rathod on 02/09/20.
//  Copyright © 2020 Dixit Rathod. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import SnapKit
import Photos
//MARK: - UIViewController
extension UIViewController{
    func setTitle(_ title:String){
        let titlelabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 25))
        titlelabel.text = title
        titlelabel.textColor = UIColor.black
        titlelabel.font = UIFont.boldSystemFont(ofSize: 19)
        let button1 = UIBarButtonItem.init(customView: titlelabel)
        self.navigationItem.leftBarButtonItem  = button1
    }
    
    class func controller<T: UIViewController>(storyId:String = "Dashboard") -> T {
        let name = String(describing: T.self)
        let story = UIStoryboard(name: storyId, bundle: nil)
        return story.instantiateViewController(withIdentifier: name) as! T
    }
    
    func failureBlock() -> FailureBlock{
        return { [weak self] failure in
            guard let self = self else {return}
            self.stopActivityIndicator()
            self.showAlertWith(message: failure)
        }
    }
    
    func fetchRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completed:@escaping((String) -> Void)) {
        
        let session = URLSession.shared
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(googleServerKey)")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
                print("error in JSONSerialization")
                return
            }
            let jsonResponse = jsonResult
            
            guard let routes = jsonResponse["routes"] as? [Any] else {
                return
            }
            
            guard let route = routes.first as? [String: Any] else {
                return
            }
            
            guard let overview_polyline = route["overview_polyline"] as? [String: Any] else {
                return
            }
            
            guard let polyLineString = overview_polyline["points"] as? String else {
                return
            }
            OperationQueue.main.addOperation {
                //Call this method to draw path on map
                completed(polyLineString)
            }
            
        })
        task.resume()
    }
    
    
    
    func showMediaPickerOptions(vc:UIViewController){
        let alert = UIAlertController(title: nil, message: "Please select option to upload your profile pic", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (camera) in
            self.openMediaPicker(with: .camera, vc: vc)
        }
        let photo = UIAlertAction(title: "Photo Library", style: .default) { (photos) in
            self.openMediaPicker(with: .photoLibrary, vc: vc)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(camera)
        alert.addAction(photo)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    func openMediaPicker(with type:UIImagePickerController.SourceType, vc:UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(type){
            let picker = UIImagePickerController()
            picker.sourceType = type
            picker.allowsEditing = true
            picker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            present(picker, animated: true, completion: nil)
        }
    }
    
    func startActivityIndicator() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let darkView = UIView(frame: self.view.bounds)
            darkView.tag = 55
            darkView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.view.addSubview(darkView)
            let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), type: .circleStrokeSpin, color: UIColor.AppColor.themeColor, padding: 10)
            indicator.center = darkView.center
            indicator.tag = 88
            darkView.addSubview(indicator)
            indicator.startAnimating()

        }
        
        
    }
    
    func addChildController(container:UIView, viewController:UIViewController){
        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.autoresizingMask = []
        container.addSubview(viewController.view)
        viewController.view.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(container).inset(UIEdgeInsets.zero)
        }
        viewController.didMove(toParent: self)
        container.layoutIfNeeded()
    }
    
    func removeChildVCs() {
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
        
    }
    
    func stopActivityIndicator() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            if let indicator = self.view.viewWithTag(88) as? NVActivityIndicatorView, let darkView = self.view.viewWithTag(55){
                indicator.stopAnimating()
                darkView.removeFromSuperview()
            }
        }
    }
    
    func showNoDataLabel(){
        view.viewWithTag(100)?.removeFromSuperview()
        let lbl = UILabel()
        lbl.text = "Your collection is empty "
        lbl.textColor = UIColor.lightGray
        lbl.textAlignment = .center
        lbl.tag = 100
        view.addSubview(lbl)
        lbl.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
        })
    }
    
    func hideNoDataLabel(){
        view.viewWithTag(100)?.removeFromSuperview()
    }
    
    
    func addNotificationBarButton(badge:Int){
        let filterBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        filterBtn.setImage(#imageLiteral(resourceName: "notification"), for: .normal)
        filterBtn.addTarget(self, action: #selector(btnNotificationTapped), for: .touchUpInside)

        let lblBadge = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 15, height: 15))
        lblBadge.backgroundColor = UIColor.black
        lblBadge.clipsToBounds = true
        lblBadge.layer.cornerRadius = 7
        lblBadge.textColor = UIColor.white
        lblBadge.font = UIFont.boldSystemFont(ofSize: 10)
        lblBadge.textAlignment = .center
        lblBadge.text = "\(badge)"
        lblBadge.isHidden = badge == 0
        filterBtn.addSubview(lblBadge)

        self.navigationItem.rightBarButtonItems = [UIBarButtonItem.init(customView: filterBtn)]
    }
    
    @objc private func btnNotificationTapped(){
        
    }
    
    
    func presentFromLeft(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .push
        transition.subtype = .fromLeft
        
        self.view.window!.layer.add(transition, forKey: kCATransition)
        viewControllerToPresent.modalPresentationStyle = .fullScreen
//        viewControllerToPresent.modalPresentationStyle = .currentContext
        present(viewControllerToPresent, animated: false)
    }
    
    func dismissLeft(complete:(() -> Void)? = nil) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false) {
            if let complete = complete{
                complete()
            }
        }
    }
    
    func addBackButton(){
        let back = UIButton()
        back.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        back.tintColor = UIColor.white
        back.addTarget(self, action: #selector(btnBackPressed), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: back)
    }
    
    func addLeftBarButton(){
        let back = UIButton()
        back.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        back.tintColor = UIColor.white
        back.addTarget(self, action: #selector(leftBarPressed), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: back)
    }
    
    
    @objc func leftBarPressed(){
        let vc:AccountMenuVC = AccountMenuVC.controller()
        self.presentFromLeft(vc)
    }
    
    func addRightBarButton(){
        let bar = UIButton()
        bar.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        bar.tintColor = UIColor.white
        bar.addTarget(self, action: #selector(rightBarPressed), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bar)
    }
    
    
    @objc func rightBarPressed(){
        
    }
    
    @objc func btnBackPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    
    func downloadVideo(url:URL){
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil);
        let downloadTask  =  session.downloadTask(with: url);
        downloadTask.resume();
    }
    func showAlertWith(message:String, isConfirmation:Bool = false, okTitle:String = "OK", cancelTitle:String = "Cancel", okPressed:(() -> Void)? = nil, cancelPressed:(() -> Void)? = nil){
//        if !isConfirmation{
//            self.view.makeToast(message, duration:2.0, position:.top)
//            return
//        }
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: okTitle, style: .default) { (action) in
            guard let okAction = okPressed else {return}
            okAction()
        }
        alert.addAction(ok)
        if isConfirmation{
            let cancel = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
                guard let cancelAction = cancelPressed else {return}
                cancelAction()
            }
            alert.addAction(cancel)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func hexToColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))
    }
}

//MARK: - Downlaod Session Delagte
extension UIViewController: URLSessionDownloadDelegate{
    //MARK: - URLDownload Task delagate
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let data = NSData(contentsOf: location){
            DispatchQueue.main.async{
                self.saveVideoToPhotoLibrary(data: data)
                self.showAlertWith(message: "Video Downloaded Successfully!")
            }
        }
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        //let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
    }
    
    
    func saveVideoToPhotoLibrary(data:NSData){
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
        let timeStamp = "\(Int(Date().timeIntervalSince1970 * 1000000))"
        
        let filePath="\(documentsPath)/\(timeStamp).mp4"
        data.write(toFile: filePath, atomically: true)
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
            print("fileURL:\(filePath)")
        }) { completed, error in
            if completed{
                print("Video is saved!")
            }else{
                print(error!.localizedDescription)
            }
        }
        
    }
}
