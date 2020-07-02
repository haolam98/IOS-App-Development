//
//  MainTabBarController.swift
//  halloweenTabBar
//
//  Created by Hao Lam on 7/1/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//
import UIKit
import TinyConstraints

class MainTabBarController: UITabBarController, UITabBarControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupViewControllers()
        
    }
    private func setupViewControllers()
    {
        let vc1 = ViewController()
        vc1.image = #imageLiteral(resourceName: "Halloween1")
        vc1.tabBarItem.image = #imageLiteral(resourceName: "MainTabBar1").withRenderingMode(.alwaysOriginal)
        vc1.tabBarItem.selectedImage = #imageLiteral(resourceName: "MainTabBar1").withRenderingMode(.alwaysOriginal)
        
        let vc2 = ViewController()
               vc2.image = #imageLiteral(resourceName: "Halloween2")
               vc2.tabBarItem.image = #imageLiteral(resourceName: "MainTabBar2").withRenderingMode(.alwaysOriginal)
               vc2.tabBarItem.selectedImage = #imageLiteral(resourceName: "MainTabBar2").withRenderingMode(.alwaysOriginal)
        
        let vc3 = DummyController()
        //vc3.image = #imageLiteral(resourceName: "Halloween3A")
        vc3.tabBarItem.image = #imageLiteral(resourceName: "MainTabBar3").withRenderingMode(.alwaysOriginal)
        vc3.tabBarItem.selectedImage = #imageLiteral(resourceName: "MainTabBar3").withRenderingMode(.alwaysOriginal)
        
        let vc4 = ViewController()
               vc4.image = #imageLiteral(resourceName: "Halloween4")
               vc4.tabBarItem.image = #imageLiteral(resourceName: "MainTabBar4").withRenderingMode(.alwaysOriginal)
               vc4.tabBarItem.selectedImage = #imageLiteral(resourceName: "MainTabBar4").withRenderingMode(.alwaysOriginal)
        
        let vc5 = ViewController()
               vc5.image = #imageLiteral(resourceName: "Halloween5")
               vc5.tabBarItem.image = #imageLiteral(resourceName: "MainTabBar5").withRenderingMode(.alwaysOriginal)
               vc5.tabBarItem.selectedImage = #imageLiteral(resourceName: "MainTabBar5").withRenderingMode(.alwaysOriginal)
        let controllers = [vc1,vc2,vc3,vc4,vc5]
        viewControllers = controllers

       // self.view.addSubview(tabBarCnt.view)
    
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        print (index)
        if index==2
        {
          
            //create actions
            let ghostAct = UIAlertAction(title: "Ghost", style: .default) {(action) in
                let vc3 = ViewController()
                vc3.image = #imageLiteral(resourceName: "Halloween3A")
                self.present(vc3, animated: true, completion: nil)
            }
            
            let catAct = UIAlertAction(title: "Cat", style: .default) {(action) in
                let vc3 = ViewController()
                vc3.image = #imageLiteral(resourceName: "Halloween3B")
                self.present(vc3, animated: true, completion: nil)
            }
            let cancelAct = UIAlertAction(title: "Cancel", style: .cancel) {
                (action) in //cancel
            }
            //create alert
            HalloweenService.showAlert(style: .actionSheet, title: "Choose One", message: nil, actions: [ghostAct,catAct,cancelAct], completion: nil)
            
        }
       
        return true
    }

}

