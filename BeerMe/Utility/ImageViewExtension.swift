//
//  ImageViewExtension.swift
//  BeerMe
//
//  Created by This Mac on 1/23/19.
//  Copyright © 2019 LopezWorks. All rights reserved.
//

import UIKit

extension UIImageView {
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit ) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {return}
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    
    func download(from link:String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else {return}
        download(from: url, contentMode: mode)
    }
}
