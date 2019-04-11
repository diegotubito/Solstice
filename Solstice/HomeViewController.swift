//
//  HomeViewController.swift
//  Solstice
//
//  Created by iMac on 11/04/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController : UIViewController {
    override func viewDidLoad() {
        super .viewDidLoad()
        
        loaderInitialization()
        
    }
    
    func loaderInitialization() {
        DDBarLoader.color = .blue
    }
    
    @IBAction func startTestButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "segue_to_list", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ListViewController {
            controller.viewModel = ListViewModel(withView: controller)
        }
    }
}
