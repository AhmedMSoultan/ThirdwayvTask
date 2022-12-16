//
//  HTTPClientProtocol.swift
//  ThirdwayvTask
//
//  Created by Ahmed Soultan on 14/12/2022.
//

import Foundation

protocol HTTPClientProtocol {
    func getData(completion: @escaping ([Product])-> Void)
}
