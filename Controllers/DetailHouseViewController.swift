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

    
    // Mark: - Properties
    var model: HouseProtocol
    
    // Mark: - Initialization
    init(model: HouseProtocol) {
        // Primero, limpias tu propio desorder
        self.model = model
        // Llamas a super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.name.rawValue
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        nameHouseLabel.text = "House \(model.name.rawValue)"
        imageSigil.image = model.sigil.imageSigil
        worksHouseLabel.text = model.words.rawValue
        self.navigationItem.title = model.name.rawValue
    }
    
    // MARK: - UI
    func setupUI() {
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        let members = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailHouseViewController: UISplitViewControllerDelegate{
    
    
}

extension DetailHouseViewController: HouseListViewControllerDelegate {
    
    func houseListViewController(_ viewController: MasterWesterosViewController, didSelectHouse house: HouseProtocol) {
        self.model = house
        syncModelWithView()
    }
}
