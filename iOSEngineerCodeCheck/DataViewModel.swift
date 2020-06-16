//
//  DataViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Yiu Cho Lam on 14/6/2020.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DataViewModel{
	
	var itemModel : BehaviorRelay<[Item]> = BehaviorRelay(value: [])
	var error : Error?
	let disposeBag = DisposeBag()
	
	func callAPI(_ url: String){
		
		guard let url_reqeust = URL(string: url) else {
			print("not found")
			return
		}
		
		let disposable = APIClient.init().call(url_reqeust).subscribe(onNext: { (data) in
			let decoder = JSONDecoder()
			do {
				let github:Github = try decoder.decode(Github.self, from: data!)
				self.itemModel.accept(github.items)
			}catch{
				self.error = error
			}
			
		}, onError: { (error) in
			self.error = error
		}, onCompleted: {
			
		}) {
			
		}
		disposable.disposed(by: disposeBag)
	}
	
}
