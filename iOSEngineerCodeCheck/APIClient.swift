//
//  APIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by Yiu Cho Lam on 14/6/2020.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol API {
	func get(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

enum HTTPError: Error {
	case invalidURL
	case invalidResponse(Data?, URLResponse?)
}

class APIClient : API{
	
	static let shared: APIClient = APIClient()
	
	func get(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
		
		
            let task = URLSession.shared.dataTask(with:url) { (data, res, err) in
				
				if err != nil{
					completion(.failure(err!))					
				}
				
				if let res = res {
					print(res)
					if let httpResponse = res as? HTTPURLResponse{
						if httpResponse.statusCode != 200{
							completion(.failure(HTTPError.invalidResponse(data, res)))
						}
					}
					guard let data = data else {return}
					
					completion(.success(data))
					
				}
						

			}
        // これ呼ばなきゃリストが更新されません
			task.resume()
	}
}
