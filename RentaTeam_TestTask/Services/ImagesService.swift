//
//  APIService.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 16.03.2022.
//

import Foundation
import Alamofire

protocol ServiceProtocol {
    func requestData(page: Int, completion: @escaping (Result<[ImageData], Error>) -> ())
}

class ImagesService: ServiceProtocol {
    private let baseURL = "https://api.unsplash.com"
    private let accessKey = "G6TlGySIDR0kV0dPm8HPwDcSERkZ3clqAHCVMrCAvQA"
    
    func requestData(page: Int, completion: @escaping (Result<[ImageData], Error>) -> ()) {
        let path = "/photos"
        let parameters: Parameters = [
            "client_id": accessKey,
            "page": "\(page)",
            "per_page": "\(15)"]
        
        AF.request(baseURL + path, method: .get, parameters: parameters).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([ImageData].self, from: data)
                    completion(.success(decodedData))
                } catch  {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
