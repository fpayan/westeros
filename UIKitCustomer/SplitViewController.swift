//
//  SplitViewController.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 5/3/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import UIKit

protocol MasterViewController {
    var collapseDetailViewController: Bool { get set }
}

protocol DetailViewController {}

final class SplitViewController: UISplitViewController {
    
    private let detailHouse:DetailHouseViewController
    private let detailSeason:SeasonDetailViewController
    
    init(detailHouse:DetailHouseViewController, detailSeason:SeasonDetailViewController) {
        self.detailHouse = detailHouse
        self.detailSeason = detailSeason
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        detail.topViewController!.navigationItem.leftBarButtonItem = displayModeButtonItem
        preferredDisplayMode = UIDevice.current.userInterfaceIdiom == .pad ? .allVisible : .automatic
    }
    
}

extension SplitViewController: UISplitViewControllerDelegate {
    
    private var master: UITabBarController {
        return viewControllers.first as! UITabBarController
    }
    
    private var detail: UINavigationController {
        return viewControllers.last as! UINavigationController
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        guard splitViewController.isCollapsed else { return false }
        guard let selected = master.selectedViewController as? UINavigationController else { return false }
        let controller: UIViewController
        if let navigation = vc as? UINavigationController {
            controller = navigation.topViewController!
        } else {
            controller = vc
        }
        controller.hidesBottomBarWhenPushed = true
        selected.pushViewController(controller, animated: true)
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController, topAsDetailController is DetailViewController else { return false }
        guard let tabBar = primaryViewController as? UITabBarController else { return false }
        for controller in tabBar.viewControllers! {
            guard let navigation = controller as? UINavigationController else { continue }
            guard let master = navigation.topViewController as? MasterViewController, master.collapseDetailViewController == false else { continue }
            topAsDetailController.hidesBottomBarWhenPushed = true
            navigation.pushViewController(topAsDetailController, animated: false)
            return true
        }
        return false
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        guard let selected = master.selectedViewController as? UINavigationController else { return nil }
        guard selected.topViewController is DetailViewController else { return nil }
        guard let details = selected.popViewController(animated: false) else { return nil }
        return UINavigationController(rootViewController: details)
    }
    
}

extension SplitViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationController = viewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first else { return }

        print("NAVIGATIONS")
        print(navigationController)
        
        let detailNavigation: UINavigationController
        if type(of: viewController ) == SeasonMasterListTableViewController.self {
            detailNavigation = self.detailSeason.naviagationControllerSesionDetail()
            print("Season Detail show")
            print(type(of: viewController ))
        } else {
            detailNavigation = self.detailHouse.naviagationControllerHouseDetail()
            print("House Detail show")
            print(type(of: viewController ))
        }

        if UIDevice.current.userInterfaceIdiom == .pad {
            splitViewController?.showDetailViewController(detailNavigation, sender: nil)
        }
    }
}


