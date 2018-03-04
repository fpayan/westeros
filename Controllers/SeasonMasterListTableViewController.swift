//
//  SeasonMasterListTableViewController.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 4/3/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import UIKit

let SEASON_KEY = "SeasonKey"
let SEASON_DID_CHANGE_NOTIFICATION_NAME = "SeasonDidChange"
let LAST_SEASON = "LAST_SEASON"

protocol SeasonListViewControllerDelegate: class {
    // should, will, did
    func seasonListViewController(_ viewController: SeasonMasterListTableViewController, didSelectSeason: SeasonProtocol)
}


class SeasonMasterListTableViewController: UITableViewController {
        
    let model:[SeasonProtocol]
    
    weak var delegate: SeasonListViewControllerDelegate?
    
    init(model:[SeasonProtocol]){
        self.model = model
        //super.init(nibName: nil, bundle: nil)
        super.init(style: .plain)
        title = "Sesions"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "CellSesion"
        
        // Configure the cell...
        let sesion = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        cell?.imageView?.image = UIImage(assetIdentifier: .IconTv)
        cell?.textLabel?.text = sesion.name
        cell?.detailTextLabel?.text = "Hi what going you ?"
        
        return cell!
    }

    // MARK: Table View Delegate
    // should, will, did
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que casa han pulsado
        let season = model[indexPath.row]
        
        
        // Aviso al delegado
        delegate?.seasonListViewController(self, didSelectSeason: season)
        
        if let detailViewController = delegate as? SeasonDetailViewController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
        
        // Mando la misma info a traves de notificaciones
        let notificationCenter = NotificationCenter.default
        
        let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY : season])
        
        notificationCenter.post(notification)
    }
    
}

extension SeasonMasterListTableViewController{
    func lastSelectedSeason() -> SeasonProtocol {
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_SEASON)
        
        // Averiguar la casa de ese row
        let season = model[row]
        
        // Devolverla
        return season
    }
}
