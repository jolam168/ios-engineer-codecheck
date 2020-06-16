//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController{

    @IBOutlet weak var SchBr: UISearchBar!
        
	@IBOutlet var tableView: UITableView!
	
    var idx: Int!
    
	var dataViewModel:DataViewModel = DataViewModel()
	let disposeBag = DisposeBag()
	
	var dataModel = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SchBr.placeholder = "GitHubのリポジトリを検索できるよー"
		SchBr.rx.text.orEmpty
			.subscribe(onNext: { (String) in
				let word = String.trimmingCharacters(in: .whitespaces)
				if word.count != 0 {
					let url:String = "https://api.github.com/search/repositories?q=\(word)"
					self.dataViewModel.callAPI(url)
				}
			}) {
				
		}.disposed(by: self.disposeBag)
		
		
		dataViewModel.itemModel.bind(to: self.tableView.rx.items){ (tableView, row, element) in
			let cell = tableView.dequeueReusableCell(withIdentifier: "Repository")!
			cell.textLabel?.text = element.fullName
			cell.detailTextLabel?.text = element.language
			cell.tag = row
			return cell
		}.disposed(by: self.disposeBag)
		
		tableView.rx.itemSelected.subscribe(onNext: { (IndexPath) in
			self.idx = IndexPath.row
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: "Detail", sender: self)
			}
		}) {
			
		}.disposed(by: self.disposeBag)
		
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let dtl = segue.destination as! ViewController2
			dtl.item = dataViewModel.itemModel.value[idx]

        }
        
    }

    
}
