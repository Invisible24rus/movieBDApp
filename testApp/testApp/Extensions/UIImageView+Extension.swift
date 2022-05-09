//
//  UIImageVuew+Extension.swift
//  testApp
//
//  Created by NIKITA NIKOLICH on 09.05.2022.
//

import UIKit

class MyImageView: UIImageView {
    
    private var task: URLSessionDataTask?
    
    func setImage(_ url: URL?, placeholder: UIImage? = nil) {
        guard let url = url else {
            image = placeholder
            return
        }

        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.image = image
                }
            }
        }
        task?.resume()
    }

    func prepareForReuse() {
        task?.cancel()
        task = nil
        image = UIImage(systemName: "umbrella")
    }
    
}
