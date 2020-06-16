//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController2: UIViewController {
    
    @IBOutlet weak var ImgView: UIImageView!
    
    @IBOutlet weak var TtlLbl: UILabel!
    
    @IBOutlet weak var LangLbl: UILabel!
    
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
	var item:Item?
	var imageViewModel:ImageViewModel = ImageViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
                
		LangLbl.text = "Written in \(item?.language ?? "")"
		StrsLbl.text = "\(item?.stargazersCount ?? 0) stars"
		WchsLbl.text = "\(item?.watchersCount ?? 0) watchers"
		FrksLbl.text = "\(item?.forksCount ?? 0) forks"
		IsssLbl.text = "\(item?.openIssuesCount ?? 0) open issues"
				
        getImage()

    }
    
    func getImage(){

		TtlLbl.text = item?.fullName ?? ""

		if let owner = item?.owner {
			imageViewModel.fetch(owner.avatarURL) { img in

				DispatchQueue.main.async {
					self.ImgView.image = img
				}
			}
		}
    }
    
}
