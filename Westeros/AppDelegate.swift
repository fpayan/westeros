//
//  AppDelegate.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 20/2/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    var seasonDetailNavigation:UINavigationController
    var houseDetailNavigation:UINavigationController
    var splitViewController:UISplitViewController
    
    init(seasonDetailNavigation:UINavigationController, houseDetailNavigation:UINavigationController, splitViewController:UISplitViewController) {
        self.seasonDetailNavigation = seasonDetailNavigation
        self.houseDetailNavigation = houseDetailNavigation
        self.splitViewController = splitViewController
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.backgroundColor = .cyan
        window?.makeKeyAndVisible()
        
        // Crear el modelo
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        let episodes = Repository.local.episodes
    
        // Creamos los controladores (masterVC, detailVC)
        let houseListVC = MasterWesterosViewController(model: houses)
        let lastSelectedHouse = houseListVC.lastSelectedHouse()
        let houseDetailVC = DetailHouseViewController(model: lastSelectedHouse)
        //
        let seasonListVC = SeasonMasterListTableViewController(model: seasons)
        let lastSelectedSeason = seasonListVC.lastSelectedSeason()
        let seasonDetailVC = SeasonDetailViewController(model: lastSelectedSeason)
        //let episodeListVC = EpisodeMasterListViewController(model: episodes)
        
        // Asignar delegados
        houseListVC.delegate = houseDetailVC
        seasonListVC.delegate = seasonDetailVC
        
        
        var seasonDetailNavigation = seasonDetailVC.wrappedInNavigation()
        var houseDetailNavigation = houseDetailVC.wrappedInNavigation()
        
        
        var splitViewController = UISplitViewController()
        
        // Se crea el Tab para los VC de Houses y Seasons
        let tabBarVC = UITabBarController()
        UITabBar.appearance().barTintColor = uicolorFromHex(rgbValue: 0x034517)
        UITabBar.appearance().tintColor = uicolorFromHex(rgbValue: 0xffffff)
        tabBarVC.delegate = self
        tabBarVC.tabBar.tintColor = UIColor.white
        houseListVC.tabBarItem = UITabBarItem(title: "Houses", image: UIImage(assetIdentifier: .IconHouse), tag: 1)
        seasonListVC.tabBarItem = UITabBarItem(title: "Seasons", image: UIImage(assetIdentifier: .IconSeason), tag: 2)
        
        tabBarVC.setViewControllers(
            [houseListVC.wrappedInNavigation(),
             seasonListVC.wrappedInNavigation()
            ], animated: true)
                
        tabBarVC.viewControllers?.forEach {
            $0.navigationItem.leftItemsSupplementBackButton = true
            $0.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        }
        
        houseDetailVC.navigationItem.leftItemsSupplementBackButton = true
        houseDetailVC.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Estamos en iPad
            splitViewController.viewControllers = [
                tabBarVC,
                houseDetailVC.wrappedInNavigation(),
                seasonDetailVC.wrappedInNavigation()
            ]
            // Asignamos el rootVC
            window?.rootViewController = splitViewController
        } else if UIDevice.current.userInterfaceIdiom == .phone {
            // Estamos en iPhone
            splitViewController.viewControllers = [
                tabBarVC,
                //houseDetailVC.wrappedInNavigation(),
                seasonDetailVC.wrappedInNavigation()
            ]
            // Asignamos el rootVC
            window?.rootViewController = splitViewController
        }
        //
        styleNavigatioBar()
        //
        return true
    }

    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func styleNavigatioBar(){
        var navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = uicolorFromHex(rgbValue: 0xffffff)
        navigationBarAppearace.barTintColor = uicolorFromHex(rgbValue: 0x034517)
        // change navigation item title color
        navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }


}

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationController = viewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first else { return }
        
        let detailNavigation: UINavigationController
        if type(of: viewController ) == SeasonMasterListTableViewController.self {
            detailNavigation = seasonDetailNavigation
        } else {
            detailNavigation = houseDetailNavigation
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            splitViewController.showDetailViewController(detailNavigation, sender: nil)
        }
    }
}

