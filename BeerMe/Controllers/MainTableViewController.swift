//
//  ViewController.swift
//  BeerMe
//
//  Created by This Mac on 1/22/19.
//  Copyright © 2019 LopezWorks. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, JSONDownloaderProtocol {
    
    var m_jsonloader : JSONDownloader?
    var m_beerData : BeersList?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        m_jsonloader = JSONDownloader()
        m_jsonloader?.m_delegate = self
        m_jsonloader?.DownloadSimpleBeers(from: "https://api.punkapi.com/v2/beers")
        
        navigationController?.navigationBar.topItem?.title = "Beers"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return m_beerData?.m_lBeers?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCellID") as? BeerTableCell
        if let data = m_beerData, let beers = data.m_lBeers {
            if indexPath.row < beers.count {
                cell?.o_lBeerName?.text = beers[indexPath.row].name
                cell?.o_imgBeerImage?.download(from: beers[indexPath.row].image_url!)
            }
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let data = m_beerData, let beers = data.m_lBeers {
            if indexPath.row < beers.count {
                let vc = (Bundle.main.loadNibNamed("BeerDetailView", owner: nil, options: nil)![0]) as! BeerDetailViewController
                vc.title = beers[indexPath.row].name!
                vc.m_iID = beers[indexPath.row].id!
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func FinishedDownloadingSimpleBeers(beerData: BeersList) {
        m_beerData = beerData
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func ErrorDownloading(error: String) {
        print(error)
    }
}

