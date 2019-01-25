//
//  BeerDetailViewController.swift
//  BeerMe
//
//  Created by This Mac on 1/23/19.
//  Copyright © 2019 LopezWorks. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController, JSONDownloaderProtocol {
    
    var m_iID : Int?
    var m_cBeer : Beer?
    var m_jsonloader : JSONDownloader?
    
    @IBOutlet var o_titleLabel : UILabel?
    @IBOutlet var o_tagline : UITextView?
    @IBOutlet var o_description : UITextView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view, typically from a nib.
        m_jsonloader = JSONDownloader()
        m_jsonloader?.m_delegate = self
        m_jsonloader?.DownloadFullBeer(from: "https://api.punkapi.com/v2/beers", with: m_iID!)
    }
    
    func InitializeViewController() {
        if let beer = m_cBeer {
            o_titleLabel?.text = beer.name!
            o_tagline?.text = beer.tagline
            o_description?.text = beer.description
            o_titleLabel?.numberOfLines = 4
        }
    }
    
    func FinishedDownloadingSingleBeer(beerData: Beer) {
        m_cBeer = beerData
        
        DispatchQueue.main.async {
            self.InitializeViewController()
        }
    }
    
    func ErrorDownloading(error: String) {
        print(error)
    }
    
    @IBAction func ShowInDepthPage() {
        if let beer = m_cBeer {
            let vc = (Bundle.main.loadNibNamed("InDepthDetailPage", owner: nil, options: nil)![0]) as! InDepthDetailPageViewController
            vc.title = ""
            vc.m_cBeer = beer
            vc.initialize()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
