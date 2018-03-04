//
//  WikiViewController.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 4/3/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {

    // Mark: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // Mark: - Properties
    var model: HouseProtocol
    
    // Mark: - Initialization
    init(model: HouseProtocol) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    // chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        loadingView.startAnimating()
        webView.navigationDelegate = self
        syncModelWithView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        title = model.name.rawValue
        webView.load(URLRequest(url: model.wikiURL))
    }
    
    // MARK: - Notifications
    @objc func houseDidChange(notification: Notification) {
        // Extraer el userInfo de la notification
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa del userInfo
        let house = info[HOUSE_KEY] as? House
        
        // Actualizar el modelo
        model = house! as! HouseProtocol
        
        // Sincronizar la vista
        syncModelWithView()
    }
}

extension WikiViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let type = navigationAction.navigationType
        switch type {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }

}
