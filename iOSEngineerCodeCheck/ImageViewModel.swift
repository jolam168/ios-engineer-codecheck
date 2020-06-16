//
//  ImageViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Yiu Cho Lam on 14/6/2020.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class ImageViewModel{
		
//	let image: Observable<UIImage?>
	var img : UIImage?

	var error : Error?
//	let disposeBag = DisposeBag()

	func fetch(_ url: String , completion: @escaping (UIImage) -> Void){

		guard let url_reqeust = URL(string: url) else {
			print("not found")
			return
		}

		APIClient.shared.get(url_reqeust) { result in
			switch result{
				case .success(let data):
					self.img = UIImage(data: data)
					completion(self.img ?? UIImage(systemName: "xmart.octogon")!)
				case .failure(let error):
					print("\(error)")
			}

		}
	}
	
//	func downloadImage(_ url:String){
//		
//		guard let url_reqeust = URL(string: url) else {
//			print("not found")
//			return
//		}
//		
//		let disposable = APIClient.init().call(url_reqeust).subscribe(onNext: { (data) in
//			
//			do {
//				
//			}catch{
//				self.error = error
//			}
//			
//		}, onError: { (error) in
//			self.error = error
//		}, onCompleted: {
//			
//		}) {
//			
//		}
//		disposable.disposed(by: disposeBag)
//		
//	}
}
