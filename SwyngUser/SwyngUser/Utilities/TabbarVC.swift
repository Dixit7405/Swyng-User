//
//  TabbarVC.swift
//  Swyng
//
//  Created by Dixit Rathod on 05/06/21.
//

import UIKit

class TabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        // Do any additional setup after loading the view.
    }
    
    func setupTabbar(){
        let vc1:HomeVC = .controller()
        let nav1 = NavController(rootViewController: vc1)
        let tabbar1 = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "home_dis"), selectedImage: #imageLiteral(resourceName: "home_sel"))
        nav1.tabBarItem = tabbar1
        self.viewControllers = [nav1]
        
        let vc2:AllSportsVC = .controller()
        let nav2 = NavController(rootViewController: vc2)
        nav2.setNavigationBarHidden(true, animated: false)
        let tabbar2 = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "booking_dis"), selectedImage: #imageLiteral(resourceName: "booking_sel"))
        nav2.tabBarItem = tabbar2
        self.viewControllers?.append(nav2)
        
        if ApplicationManager.sportType == .tournaments{
            let vc3:TournamentGridVC = .controller()
            let nav3 = NavController(rootViewController: vc3)
            nav3.setNavigationBarHidden(true, animated: false)
            let tabbar3 = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "tournament_dis"), selectedImage: #imageLiteral(resourceName: "tournament_sel"))
            nav3.tabBarItem = tabbar3
            self.viewControllers?.append(nav3)
        }
        else{
            let vc3:TournamentGridVC = .controller()
            let nav3 = NavController(rootViewController: vc3)
            nav3.setNavigationBarHidden(true, animated: false)
            let tabbar3 = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "marathon 2"), selectedImage: #imageLiteral(resourceName: "marathon 2"))
            nav3.tabBarItem = tabbar3
            self.viewControllers?.append(nav3)
        }
        
        let vc4:MenuVC = .controller()
        let nav4 = NavController(rootViewController: vc4)
        nav4.setNavigationBarHidden(true, animated: false)
        let tabbar4 = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "clock_dis"), selectedImage: #imageLiteral(resourceName: "clock_sel"))
        nav4.tabBarItem = tabbar4
        self.viewControllers?.append(nav4)
        
//        self.viewControllers = [nav1, nav2, nav4]
        
    }

}
