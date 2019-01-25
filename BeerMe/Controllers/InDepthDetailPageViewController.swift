//
//  InDepthDetailPageViewController.swift
//  BeerMe
//
//  Created by This Mac on 1/24/19.
//  Copyright © 2019 LopezWorks. All rights reserved.
//

import UIKit

class InDepthDetailPageViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var o_tIngredientsList : UITableView?
    @IBOutlet var o_lContributeBrewer : UILabel?
    @IBOutlet var o_tvBrewerNote : UITextView?
    var m_cBeer : Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        o_tIngredientsList?.delegate = self
        o_tIngredientsList?.dataSource = self
        
        o_tIngredientsList?.register(UINib(nibName: "IngredientsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ingredientCell")
        
    }
    
    func initialize() {
        guard let beer = m_cBeer else {return}
        if let contrib = beer.contributed_by {
            o_lContributeBrewer?.text = contrib
        }
        if let tips = beer.brewers_tips {
            o_tvBrewerNote?.text = tips
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let beer = m_cBeer else { return 0 }
        var sectionCount = 0
        if let _ = beer.ingredients?.hops {
            sectionCount += 1
        }
        
        if let _ = beer.ingredients?.malt {
            sectionCount += 1
        }
        
        if let _ = beer.ingredients?.yeast {
            sectionCount += 1
        }
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let beer = m_cBeer {
            if section == 0 {
                return beer.ingredients?.hops!.count ?? 0
            } else if section == 1 {
                return beer.ingredients?.malt?.count ?? 0
            } else if section == 2 {
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let beer = m_cBeer else { return nil }
        if section == 0 {
            return "Hops"
        } else if section == 1 {
            return "Malt"
        } else if section == 2 {
            return "Yeast"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") as! IngredientsTableCell
        
        if let beer = m_cBeer {
            if indexPath.section == 0 {
                cell.o_lName!.text = beer.ingredients?.hops![indexPath.row].name
                
                let value = beer.ingredients?.hops![indexPath.row].amount?.value!
                let unit = AbbrevMap[(beer.ingredients?.hops![indexPath.row].amount?.unit)!]
                cell.o_lAmount!.text = value!.description + unit!.description
            } else if indexPath.section == 1 {
                cell.o_lName?.text = beer.ingredients?.malt![indexPath.row].name
                
                let value = beer.ingredients?.malt![indexPath.row].amount?.value!
                let unit = AbbrevMap[(beer.ingredients?.malt![indexPath.row].amount?.unit)!]
                cell.o_lAmount!.text = value!.description + unit!.description
            } else if indexPath.section == 2 {
                cell.o_lName?.text = beer.ingredients?.yeast
                cell.o_lAmount!.text = nil
            }
        }
        return cell
    }
}
