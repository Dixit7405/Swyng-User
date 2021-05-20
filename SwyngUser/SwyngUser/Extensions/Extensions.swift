//
//  Extensions.swift
//  MyTremolo Teacher
//
//  Created by Dixit Rathod on 15/10/20.
//

import Foundation
import UIKit
import Kingfisher

//MARK: - DATE
extension Date {

    func getWeekDates() -> (thisWeek:[Date],nextWeek:[Date]) {
        var tuple: (thisWeek:[Date],nextWeek:[Date])
        var arrThisWeek: [Date] = []
        for i in 0..<7 {
            arrThisWeek.append(Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)!)
        }
        var arrNextWeek: [Date] = []
        for i in 1...7 {
            arrNextWeek.append(Calendar.current.date(byAdding: .day, value: i, to: arrThisWeek.last!)!)
        }
        tuple = (thisWeek: arrThisWeek,nextWeek: arrNextWeek)
        return tuple
    }

    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    func dateAfterDays(day:Int) -> Date{
        return Calendar.current.date(byAdding: .day, value: day, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func getNextMonth()->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:self)!
    }

    func getPreviousMonth()->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:self)!
    }

    var startOfWeek: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        return gregorian.date(byAdding: .day, value: 1, to: sunday!)!
    }

    func toDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getNextWeek()->Date {
        return  Calendar.current.date(byAdding: .weekOfMonth, value: 1, to:self)!
    }

    func getPreviousWeek()->Date {
        return  Calendar.current.date(byAdding: .weekOfMonth, value: -1, to:self)!
    }
}



extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

//MARK: - UITEXTFIELD
extension UITextField{
    @IBInspectable var placeholderColor:UIColor{
        set{
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                         attributes: [NSAttributedString.Key.foregroundColor: newValue])

        }
        get{
            return self.placeholderColor
        }
    }
    
    func showValidation(message:String){
        self.text = ""
        self.attributedPlaceholder = NSAttributedString(string: message, attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    var htmlToString:String{
        let str = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let mainStr =  str.replacingOccurrences(of: "&[^;]+;", with: "", options: .regularExpression, range: nil)
        let trimmed = mainStr.trimmingCharacters(in: .whitespacesAndNewlines)
        return /*trimmed.count > 50 ? "\(trimmed.prefix(50)).." :*/ trimmed
    }
    
    var htmlToCompleteString:String{
        let str = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let mainStr =  str.replacingOccurrences(of: "&[^;]+;", with: "", options: .regularExpression, range: nil)
        return mainStr.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var toDate:String{
        return self.convertDate(format: "yyyy-MM-dd").toDate(format: "yyyy/MM/dd")
    }
    
    var doubleValue:Double{
        return Double(self) ?? 0
    }
    
    var intValue:Int{
        return Int(Double(self) ?? 0)
    }
}

//MARK: - UIIMAGEVIEW
extension UIImageView{
    func setImage(from path:String?){
        if let urlString = path?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string:imageBase + urlString){
            self.kf.setImage(with: url)
        }
    }
}

//MARK: - integer
extension Int{
    func toString() -> String{
        String(describing: self)
    }
}


//MARK: - integer
extension Double{
    func toString() -> String{
        String(describing: self)
    }
}

extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: backgroundColor!), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }

    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {return UIImage()}
        context.setFillColor(color.cgColor);
        context.fill(rect);
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() };
        UIGraphicsEndImageContext();
        return image
    }
}
