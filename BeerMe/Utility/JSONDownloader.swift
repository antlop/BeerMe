//
//  JSONDownloader.swift
//  BeerMe
//
//  Created by This Mac on 1/22/19.
//  Copyright © 2019 LopezWorks. All rights reserved.
//

import Foundation

protocol JSONDownloaderProtocol {
    func FinishedDownloadingSingleBeer(beerData: Beer)
    func FinishedDownloadingSimpleBeers(beerData: BeersList)
    func ErrorDownloading(error:String)
}
/* :: implementation to make the method optional ::*/
extension JSONDownloaderProtocol {
    func FinishedDownloadingSimpleBeers(beerData: BeersList) {    }
    func FinishedDownloadingSingleBeer(beerData: Beer) {    }
}

class JSONDownloader: NSObject {
    
    var m_delegate : JSONDownloaderProtocol?
    
    func DownloadSimpleBeers(from:String) {
        
        guard let url = URL(string: from) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let beerdata = try decoder.decode([SimpleBeer?].self, from: data)
                let beers = BeersList(beers: beerdata)
                
                
                if let delegate = self.m_delegate {
                    delegate.FinishedDownloadingSimpleBeers(beerData: beers)
                }
                
            } catch let err {
                if let delegate = self.m_delegate {
                    delegate.ErrorDownloading(error: err.localizedDescription)
                }
            }
        }.resume()
    }
    
    func DownloadFullBeer(from:String, with ID:Int) {
        
        guard let url = URL(string: from + "/\(ID)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let beerdata = try decoder.decode([Beer?].self, from: data)
                
                
                if let delegate = self.m_delegate {
                    delegate.FinishedDownloadingSingleBeer(beerData: beerdata[0]!)
                }
                
            } catch let err {
                if let delegate = self.m_delegate {
                    delegate.ErrorDownloading(error: err.localizedDescription)
                }
            }
            }.resume()
    }
}
