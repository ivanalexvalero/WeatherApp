//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Ivan Valero on 27/10/2021.
//

import Foundation


// ultimo modelo con los datos de respuesta con las propiedades creadas anteriormente en los demas structs

// modelo llamado por el nombre de los principales tipos de datos del json

struct ResponseWeatherDataModel: Decodable {
    let city: String
    let weather: [WeatherDataModel]
    let temperature: TemperatureWeatherDataModel
    // timezone esta en el mismo nivel que city en el Json
    let timezone: Double
    let sun: SunModel
    
    
    enum CodinKeys: String, CodingKey {
        case city = "name"
        case weather
        case temperature = "main"
        case timezone
        case sun = "sys"
    }
    // iniciamos el CodinKeys para evitar errores de nil como en temperature = "main"
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodinKeys.self)
        self.city = try container.decode(String.self, forKey: .city)
        self.weather = try container.decode([WeatherDataModel].self, forKey: .weather)
        self.temperature = try container.decodeIfPresent(TemperatureWeatherDataModel.self, forKey: .temperature)!
        self.timezone = try container.decode(Double.self, forKey: .timezone)
        self.sun = try container.decode(SunModel.self, forKey: .sun)
    }
}

// !!!!!!!!!!!!! Armamos los modelos de datos del json para traerlos en lineas de código

// modelo para mostrar el sunrise y sunset

struct SunModel: Decodable {
    let sunrise: Date
    let sunset: Date
}

// armamos el modelo de "Weather" con los datos principales del json

struct WeatherDataModel: Decodable {
    let main: String
    let description: String
    let iconURLString: String
    
    // debemos mapear los datos para corresponder los nombres
    
    enum CodingKeys: String, CodingKey {
        case main
        case description
        case iconURLString = "icon"
    }

}

// armamos el 2do modelo con la informacion sobre la temperatura que es el "Main" del jason

struct TemperatureWeatherDataModel: Decodable {
    let currentTemperature: Double
    let maxTemperature: Double
    let minTemperature: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case maxTemperature = "temp_max"
        case minTemperature = "temp_min"
        case humidity
    }
}






/*
 

{
"coord": {
"lon": -122.08,
"lat": 37.39
},
"weather": [
{
"id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d"
}
],
"base": "stations",
"main":     {
            "temp": 282.55,
            "feels_like": 281.86,
            "temp_min": 280.37,
            "temp_max": 284.26,
            "pressure": 1023,
            "humidity": 100
            },
"visibility": 16093,
"wind": {
"speed": 1.5,
"deg": 350
},
"clouds": {
"all": 1
},
"dt": 1560350645,
"sys": {
"type": 1,
"id": 5122,
"message": 0.0139,
"country": "US",
"sunrise": 1560343627,
"sunset": 1560396563
},
"timezone": -25200,
"id": 420006353,
                "name": "barcelona",
"cod": 200
}


 */
