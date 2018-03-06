//
//  DetailHouseViewController.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 1/3/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//
import Foundation
import UIKit

class DetailHouseViewController: UIViewController {
    // Mark: - Outlets
    @IBOutlet weak var nameHouseLabel: UILabel!
    @IBOutlet weak var imageSigil: UIImageView!
    @IBOutlet weak var worksHouseLabel: UILabel!

//    var splitVC: UISplitViewController!
    
    // Mark: - Properties
    var model: HouseProtocol
    
    // Mark: - Initialization
    init(model: HouseProtocol) {
        // Primero, limpias tu propio desorder
        self.model = model
//        self.splitVC = UISplitViewController()
        // Llamas a super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.name.rawValue
    }
    
    // Delete object of memory
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
        
    // Chapuza de los de Cupertino relacionada con los nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        syncModelWithView()
        notificationDeviceCurrentOrientation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        guard
            self.nameHouseLabel != nil,
            self.imageSigil != nil,
            self.worksHouseLabel != nil
            else{
            return
        }
        nameHouseLabel.text = "House \(model.name.rawValue)"
        imageSigil.image = model.sigil.imageSigil
        worksHouseLabel.text = model.words.rawValue
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.title = model.name.rawValue
    }
    
    // MARK: - UI
    func setupUI() {
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        let members = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        navigationItem.backBarButtonItem?.style = .plain
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [wikiButton, members]
    }
    
    
    
    @objc func displayWiki() {
        // Creamos el WikiVC
        let wikiViewController = WikiViewController(model: model)
        
        // Hacemos push
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
    
    @objc func displayMembers() {
        // Creamos el VC
        let memberListViewController = MemberListViewController(model: model.sortedMembers )
        
        // Hacemos Push
        navigationController?.pushViewController(memberListViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print( "INDENTIFIER: \n \(String(describing: segue.identifier))" )
    }

    public func naviagationControllerHouseDetail() -> UINavigationController{
        guard let nav = self.navigationController else{
            return UINavigationController()
        }
        return nav
    }

}

extension DetailHouseViewController{
    func notificationDeviceCurrentOrientation(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.orientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc func orientation() {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            print("landscapeLeft DETAIL")
        } else if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            print("landscapeRight DETAIL")
        } else if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            print("portrait DETAIL")
        } else if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
            print("portraitUpsideDown DETAIL")
        }
    }
}


extension DetailHouseViewController: HouseListViewControllerDelegate {
    
    func houseListViewController(_ viewController: MasterWesterosViewController, didSelectHouse house: HouseProtocol) {
        self.model = house
        syncModelWithView()
    }
}
