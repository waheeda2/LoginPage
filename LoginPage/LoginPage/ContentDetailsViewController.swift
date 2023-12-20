//
//  ContentDetailsViewController.swift
//  LoginPage
//
//  Created by Waheeda Dudekula on 27/03/23.
//  Copyright © 2023 Waheeda Dudekula and Sai Varshith. All rights reserved.
//

import UIKit

class ContentDetailsViewController: UIViewController {

    @IBOutlet weak var urlImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var contentName: UILabel!
    @IBOutlet weak var genre: UILabel!
    
    var artistDetails: Results!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        artistName.text = artistDetails.artistName
        contentName.text = artistDetails.name
        
        navigationItem.title = artistDetails.name
        
        if artistDetails.genres.isEmpty {
            genre.text = "-"
        } else {
            genre.text = artistDetails.genres[0].name
        }
        
        guard let url = URL(string: artistDetails.artworkUrl100) else {return}
        let dataTask = URLSession.shared.dataTask(with: url){ (data, _, _) in
            if let data = data{
                DispatchQueue.main.async {
                    self.urlImage.image = UIImage(data: data)
                }
            }
        }
        dataTask.resume()
        
    }
    

}
