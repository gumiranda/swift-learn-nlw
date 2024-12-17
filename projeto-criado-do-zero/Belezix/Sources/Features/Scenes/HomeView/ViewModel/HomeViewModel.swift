//
//  HomeViewModel.swift
//  Belezix
//
//  Created by Gustavo Miranda de Aguiar on 17/12/24.
//

import Foundation
import CoreLocation

class HomeViewModel {
    private let baseURL = "http://127.0.0.1:3333"
    var userLatitude = -23.561187293883442
    var userLongitude = -46.656451388116494
    
    var didUpdateCategories: (() -> Void)?
    var didUpdatePlaces: (() -> Void)?

}
