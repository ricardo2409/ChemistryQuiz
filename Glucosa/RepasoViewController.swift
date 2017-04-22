//
//  RepasoViewController.swift
//  Glucosa
//
//  Created by Ricardo on 4/22/17.
//  Copyright © 2017 Ricardo. All rights reserved.
//

import UIKit

class RepasoViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.isNavigationBarHidden = false
        
        webView.loadRequest(URLRequest(url: URL(string: "https://docs.google.com/presentation/d/1UQmkYkMCYXeHpQuLOk6f-ojc9vKKP_AuTH-Si8NF8AU/edit#slide=id.p")!))
        
       

    }

   

}
