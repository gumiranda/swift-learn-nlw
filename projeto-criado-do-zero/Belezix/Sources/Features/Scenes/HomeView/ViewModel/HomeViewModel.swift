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
    
    var categories: [Category] = []
    var places: [Place] = []
    var filteredPlaces: [Place] = []

    var didUpdateCategories: (() -> Void)?
    var didUpdatePlaces: (() -> Void)?
    
    func fetchInitialData(completion: @escaping ([Category]) -> Void) {
            fetchCategories { categories in
                completion(categories)
                if let foodCategory = categories.first(where: { $0.name == "Alimentação" }) {
                    self.fetchPlaces(for: foodCategory.id, userLocation: CLLocationCoordinate2D(latitude: self.userLatitude, longitude: self.userLongitude))
                }
            }
    }
    
     func fetchCategories(completion: @escaping ([Category]) -> Void){
        guard let url = URL(string: "\(baseURL)/categories") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, _, error in
            if let error = error {
                print("Deu erro \(error)")
                return
            }
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let categories = try JSONDecoder().decode([Category].self, from: data)
                DispatchQueue.main.async {
                    completion(categories)
                }
            } catch let decodingError {
                print("Erro ao decodificar categorias: \(decodingError.localizedDescription)")
                completion([])
            }
            
        }.resume()
    }
    
     func fetchPlaces(for categoryID: String, userLocation: CLLocationCoordinate2D){
        guard let url = URL(string: "\(baseURL)/markets/category/\(categoryID)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, _, error in
            if let error = error {
                print("Deu erro \(error)")
                return
            }
            guard let data = data else {
                return
            }
            
            do {
                self.places = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.async {
                    self.didUpdatePlaces?()
                }
            } catch {
                print("Deu erro ao pegar places")
            }
            
        }.resume()
    }

}
