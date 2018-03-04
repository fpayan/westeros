//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 4/3/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    
    @IBOutlet weak var nameSesion: UILabel!
    @IBOutlet weak var dateSesion: UILabel!

    @IBAction func btnEpisode(_ sender: UIButton) {
        print("Click episodes button")
    }
    
    // Mark: - Properties
    var model: SeasonProtocol
    
    // Mark: - Initialization
    init(model: SeasonProtocol) {
        // Primero, limpias tu propio desorder
        self.model = model
        // Llamas a super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.name
    }
    
    // Chapuza de los de Cupertino relacionada con los nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        guard nameSesion != nil, dateSesion != nil else{
            return
        }
        nameSesion.text = model.name
        dateSesion.text = model.dateLaunch.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModelWithView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate{
    func seasonListViewController(_ viewController: SeasonMasterListTableViewController, didSelectSeason season: SeasonProtocol) {
        self.model = season
        syncModelWithView()
    }   
}
