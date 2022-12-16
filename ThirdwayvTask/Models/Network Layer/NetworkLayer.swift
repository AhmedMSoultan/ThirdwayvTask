//
//  NetworkLayer.swift
//  ThirdwayvTask
//
//  Created by Ahmed Soultan on 14/12/2022.
//
import Alamofire
import Foundation

class NetworkLayer {
    
    //MARK: - VARIABLES
    
    static let shared = NetworkLayer()
    
    //MARK: - INIT
    private init() {}
}

// MARK: - GET
extension NetworkLayer {
    func get<T>(endPoint: EndPoint, className: T.Type, param: Parameters? = nil, completionHandler: @escaping ([Product]) -> ()) where T: Decodable {
        AF.request(endPoint.url, parameters: nil, headers: nil).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success:
                guard let data = response.value else { return }
                completionHandler(data as! [Product])
            case .failure(let error):
                print(error)
                completionHandler([Product]())
            }
        }
    }
}
