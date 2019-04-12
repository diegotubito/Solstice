//
//  ViewController.swift
//  Solstice
//
//  Created by iMac on 11/04/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ListViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : ListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        //some init
        registerCells()
        
        //load info list from url, then show on table view.
        viewModel?.loadData()
       
    }
    
    func registerCells() {
        tableView.register(TableViewCellRegisterList.nib, forCellReuseIdentifier: TableViewCellRegisterList.identifier)
    }
    
    func showError(_ value: String) {
        let alert = UIAlertController.init(title: title, message: value, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            DDBarLoader.showLoading(controller: self, message: "Loading")
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            DDBarLoader.hideLoading()
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.model.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellRegisterList.identifier, for: indexPath) as? TableViewCellRegisterList {
            cell.nameCell.text = self.viewModel?.name(indexPath.row)
            cell.companyNameCell.text = self.viewModel?.companyName(indexPath.row)
           
            //this line avoid wrong image show
            cell.iconImageCell.image = #imageLiteral(resourceName: "User Icon Small")
            //this solve flickering issue
            cell.tag = indexPath.row
            self.viewModel?.loadImage(indexPath.row, success: { (image) in
                //the if clause avoid flickering
                if cell.tag == indexPath.row {
                    cell.iconImageCell.image = image
                }
                
            }, fail: { (error) in
                //the if clause avoid flickering
                if cell.tag == indexPath.row {
                    cell.iconImageCell.image = #imageLiteral(resourceName: "User Icon Small")
                }
                
            })
            
            if self.viewModel?.isFavorite(indexPath.row) ?? false {
                cell.starImageCell.image = #imageLiteral(resourceName: "Favorite — True")
            } else {
                cell.starImageCell.image = nil
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}


extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
