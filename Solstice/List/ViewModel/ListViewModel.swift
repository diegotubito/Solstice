//
//  ListViewModel.swift
//  Solstice
//
//  Created by iMac on 11/04/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

class ListViewModel: ListViewModelProtocol {
  
    
    
    
    
   
    
    
    var model: [ListModel]!
    var _view : ListViewProtocol!
    
    required init(withView view: ListViewProtocol) {
        //initialize _view
        _view = view
       
        //create an empty list
        model = [ListModel]()
        
    }
    
    
    func loadData() {
        //show loading animation
        _view.showLoading()
        
        //load data from endpoint "https://s3.amazonaws.com/technical-challenge/v3/contacts.json"
        ServiceManager.retrieveData(onSuccess: { (response) in
            //success, load model and show data in table view
            
            //hide loading animation
            self._view.hideLoading()
            
            //remove list
            self.model.removeAll()
            
            //load list into model array
            response.forEach({ (jsonRegister) in
                let newRegister = ListModel(json: jsonRegister)
                self.model.append(newRegister)
            })
            
            //show all register in table view
            self._view.showList()
            
        }) { (error) in
            //hide loading animation
            self._view.hideLoading()
            
            //show and error message
            self._view.showError(error.localizedDescription)
        }
    }
    
    func loadImage(_ index: Int, success: @escaping (UIImage) -> Void, fail: @escaping (String) -> Void) {
        if let url = model[index].smallImageURL {
            ServiceManager.downloadImageFromUrl(url: url, result: { (image) in
                if image != nil {
                    success(image!)
                }
            }) { (err) in
                fail(err?.localizedDescription ?? "Error")
            }
        }
    }
    
}


//protocol methods
extension ListViewModel {
    
    func numberOfRegisters() -> Int {
        return model.count
    }
    
    func name(_ index: Int) -> String? {
        return model[index].name
    }
    
    func companyName(_ index: Int) -> String? {
        return model[index].companyName
    }
    
    func isFavorite(_ index: Int) -> Bool? {
        return model[index].isFavorite
    }
    
}
