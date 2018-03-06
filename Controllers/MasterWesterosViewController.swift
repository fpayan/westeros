//
//  MasterWesterosViewController.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 1/3/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import UIKit

let HOUSE_KEY = "HouseKey"
let HOUSE_DID_CHANGE_NOTIFICATION_NAME = "HouseDidChange"
let LAST_HOUSE = "LAST_HOUSE"

protocol HouseListViewControllerDelegate: class {
    // should, will, did
    func houseListViewController(_ viewController: MasterWesterosViewController, didSelectHouse house: HouseProtocol)
}

class MasterWesterosViewController: UITableViewController {
    
    // Mark: - Properties
    var model:[HouseProtocol]
    // Hacemos delegado a todo el que extienda de HouseListViewControllerDelegate protocol
    // En este caso lo hace DetailHouseViewController
    weak var delegate: HouseListViewControllerDelegate?
    
    // Mark: - Initialization
    init(model: [HouseProtocol]){
        self.model = model
        //super.init(nibName: nil, bundle: nil)
        super.init(style: .plain)
        title = "Westeros"
    }
    
    // Caca o Cocoa.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.orientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func orientation() {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            print("landscapeLeft MASTER")
        } else if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            print("landscapeRight MASTER")
        } else if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            print("portrait MASTER")
        } else if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
            print("portraitUpsideDown MASTER")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        //clearsSelectionOnViewWillAppear = splitViewController?.isCollapsed
        super.viewWillAppear(animated)
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
        let cellId = "CellHouse"

        // Configure the cell...
        let house = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.imageView?.image = house.sigil.imageSigil
        cell?.textLabel?.text = house.name.rawValue
        //cell?.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    // MARK: Table View Delegate
    // should, will, did
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que casa han pulsado
        let house = model[indexPath.row]
        
        //let houseDetailVC = DetailHouseViewController(model: house)
        
        // Aviso al delegado
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        if let detailViewController = delegate as? DetailHouseViewController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
        
        // Mando la misma info a traves de notificaciones
        let notificationCenter = NotificationCenter.default
        
        let notification = Notification(name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [HOUSE_KEY : house])
        
        notificationCenter.post(notification)
        
        // Guardar las coordenadas (section, row) de la ultima casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
        
    }
    
    
}

// MARK: - Delegate
extension MasterWesterosViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ viewController: MasterWesterosViewController, didSelectHouse house: HouseProtocol) {
        let houseDetailViewController = DetailHouseViewController(model: house)
        navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
}

extension MasterWesterosViewController {
    func saveLastSelectedHouse(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_HOUSE)
        // Por si las moscas
        defaults.synchronize()
    }
    
    func lastSelectedHouse() -> HouseProtocol {
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_HOUSE)
        
        // Averiguar la casa de ese row
        let house = model[row]
        
        // Devolverla
        return house 
    }
}
