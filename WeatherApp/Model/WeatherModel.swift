 //
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Ivan Valero on 28/10/2021.
//

import Foundation



// creamos un modelo para juntar todas las propiedades y ponerlas al mismo nivel en un Struct
// además, creamos una propiedad para evitar opcionales

struct WeatherModel {
    let city: String
    let weather: String
    let description: String
    let iconURL: URL?
    let currentTempetarute: String
    let maxTemperature: String
    let minTemperature: String
    let humidity: String
    let sunrise: Date
    let sunset: Date
    
    // inicializamos los componentes con aspectos por defecto para evitar opcionales o nils
    
    static let empty: WeatherModel = .init(city: "No City",
                                           weather: "No weather",
                                           description: "No description",
                                           iconURL: nil,
                                           currentTempetarute: "0º",
                                           maxTemperature: "0º max",
                                           minTemperature: "0º min",
                                           humidity: "0%",
                                           sunrise: .distantFuture,
                                           sunset: .distantFuture)
}
