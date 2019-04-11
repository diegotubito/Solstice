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
        print("error")
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
           
            self.viewModel?.loadImage(indexPath.row, success: { (image) in
                DispatchQueue.main.async {
                    cell.iconImageCell.image = image
                }
                
            }, fail: { (error) in
                print("no hay imagen")
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
