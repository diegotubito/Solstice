//
//  ListViewModelProtocol.swift
//  Solstice
//
//  Created by iMac on 11/04/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewModelProtocol {
    init(withView view: ListViewProtocol)
    
    var model : [ListModel]! {get}
    func loadData()
    func loadImage(_ index: Int, success:  @escaping (UIImage) -> Void, fail:  @escaping (String) -> Void)
    func numberOfRegisters() -> Int
    func name(_ index: Int) -> String?
    func companyName(_ index: Int) -> String?
    func isFavorite(_ index: Int) -> Bool?
}

protocol ListViewProtocol {
    func showError(_ value: String)
    func showList()
    func showLoading()
    func hideLoading()
}
