//
//  WeatherModelMapper.swift
//  WeatherApp
//
//  Created by Ivan Valero on 28/10/2021.
//

import Foundation

// para usar este Mapper debemos instanciarlo en el viewModel
struct WeatherModelMapper {
    
    // parámetro de entrada - WeatherDataModel
    // y un parámetro de salida que es el nuevo model - WeatherModel
    func mapDataModelToModel(weatherData: ResponseWeatherDataModel) -> WeatherModel {
        // comprobamos que tenemos un valor en el array del weather(Modulo 1), sino devolvemos un valor empty
        guard let weather = weatherData.weather.first else {
            return .empty
        }
        
        // calculos con las fechas segun la zona hoaria
        
        let sunsetWithTimezone = weatherData.sun.sunset.addingTimeInterval(weatherData.timezone - Double(TimeZone.current.secondsFromGMT()))
        let sunriseWithTimezone = weatherData.sun.sunrise.addingTimeInterval(weatherData.timezone - Double(TimeZone.current.secondsFromGMT()))
        
        // comprobamos el valor de temperatura y sus datos
        let temperature = weatherData.temperature
        // y retornamos el WeatherModel con los datos del Json que usabamos en la vista pero mejorados
        return WeatherModel(city: weatherData.city,
                            weather: weather.main,
                            description: "(\(weather.description))",
                            iconURL: URL(string: "http://openweathermap.org/img/wn/\(weather.iconURLString)@2x.png"),
                            currentTempetarute: "\(Int(temperature.currentTemperature))º",
                            maxTemperature: "\(Int(temperature.maxTemperature))º max",
                            minTemperature: "\(Int(temperature.minTemperature))º min",
                            humidity: "\(temperature.humidity)%",
                            sunrise: sunriseWithTimezone, sunset: sunsetWithTimezone)
        
    }
    
    
}
