//
//  SeasonMasterListTableViewController.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 4/3/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import UIKit

class SeasonMasterListTableViewController: UITableViewController {
        
    let model:[SeasonProtocol]
    
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

    
}
