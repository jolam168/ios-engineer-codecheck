//
//  DataViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Yiu Cho Lam on 14/6/2020.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

class DataViewModel{
	
	var dataModel = [Item]()
		
	func fetch(_ url: String , completion: @escaping ([Item]) -> Void){
		
		guard let url_reqeust = URL(string: url) else {
			print("not found")
			return
		}
		
		APIClient.shared.get(url_reqeust) { result in
			switch result{
				case .success(let data):
					let decoder = JSONDecoder()
					do{
						
						let github:Github = try decoder.decode(Github.self, from: data)
						self.dataModel = github.items
						print(github)
						completion(self.dataModel)
					} catch let error{
						print ("error is \(error)")
					}
				case .failure(let error):
					print("\(error)")
			}
			
		}
	}
	
	func count() -> Int{
		return dataModel.count
	}
}
