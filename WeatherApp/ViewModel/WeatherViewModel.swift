//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Ivan Valero on 27/10/2021.
//

import Foundation



// método que hará la petición http al endPoint

// http://api.openweathermap.org/data/2.5/weather?q=barcelona&appid=a4437bf3fea91f76f7b038a30af27952&units=metric&lang=es

// método


final class WeatherViewModel: ObservableObject {
    
    // esta variable permite conectar el Model con el ViewModel y asi pasarle la info a la View
    //@Published var responseWeatherDataModel: ResponseWeatherDataModel?
    
    // al usar le nuevo Model y Mapper debemos cambiar la @Published var
    @Published var weatherModel: WeatherModel = .empty
    // y ademas intanciamos nuestro Mapper
    private let weatherModelMapper: WeatherModelMapper = WeatherModelMapper()
    
    func getWeather(city: String) async {
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a4437bf3fea91f76f7b038a30af27952&units=metric&lang=es")!
        
        
        do {
            async let (data, _) = try await URLSession.shared.data(from: url)
            let weatherData = try! await JSONDecoder().decode(ResponseWeatherDataModel.self, from: data)
            DispatchQueue.main.async {
           //
           //                // este self deja de funcionar por usar el nuevo Model y Mapper
           //                //self.responseWeatherDataModel = weatherData
           //
           //
           //                // lo reemprazamos por la siguiente función
                           self.weatherModel = self.weatherModelMapper.mapDataModelToModel(weatherData: weatherData)
           //
                       }
        }
        
    }

    
}




//final class WeatherViewModel {
//
//    private var responseWeatherDataModel: ResponseWeatherDataModel?
//    // operación para hacer la petición de obtener el clima
//
//    // le pasamos un paramtro que es la city
//    func getWeather(city: String){
//        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a4437bf3fea91f76f7b038a30af27952&units=metric&lang=es") else { return }
//
//        // tomamos el URLSession y llamamos al método dataTask que hará la peticion http
//        URLSession.shared.dataTask(with: url) {data, response, error in
//            print("📀Data \(String(describing: data))")
//            print("🗣Response \(String(describing: response))")
//            print("🚨Error \(String(describing: error))")
//
//            // si estamos recibiendo data, vamos a tratarlo dentro de este if
//
//            // primero revisamos que no hubo ningun error y si es nulo, crear data
//            guard error == nil, let data = data else { return }
//
//            // si logramos obtener los datos, queremos decodificarlos para
//            if let response = try? JSONDecoder().decode(ResponseWeatherDataModel.self, from: data) {
//                self.responseWeatherDataModel = response
//            } else {
//                print(error!.localizedDescription)
//            }
//
//
//
//        }.resume()
//    }
//
//}


// func anterior

//func getWeather(city: String) {
//    guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a4437bf3fea91f76f7b038a30af27952&units=metric&lang=es") else { return }
//
//    // aqui hacemos la peticion http al data y el data se lo pasamos al weatherData y el weatherData se lo pasamos al método self. que esta dentro del DospatchQueue que es el método de nuestro mapper
//    // que es el encargado de transformar la info para la vista-----CórdobaAR
//    URLSession.shared.dataTask(with: url) {data, response, error in
//        if let _ = error {
//            print("Error")
//        }
//
//        if let data = data,
//           let weatherResponse = response as? HTTPURLResponse,
//           weatherResponse.statusCode == 200 {
//            let weatherData = try! JSONDecoder().decode(ResponseWeatherDataModel.self, from: data)
//            print(weatherData)
//            // usamos esto para solucionar un error de actualizacion
//            // cambio en un hilo que esta en background en la ui y no puede pasar nunca
//            // se soluciona con el DispatchQueue para redirigirlo al hilo principal
//            DispatchQueue.main.async {
//
//                // este self deja de funcionar por usar el nuevo Model y Mapper
//                //self.responseWeatherDataModel = weatherData
//
//
//                // lo reemprazamos por la siguiente función
//                self.weatherModel = self.weatherModelMapper.mapDataModelToModel(weatherData: weatherData)
//
//            }
//
//        }
////            guard error == nil, let data = data else { return }
////
////            if let response = try? JSONDecoder().decode(ResponseWeatherDataModel.self, from: data) {
////                self.responseWeatherDataModel = response
////            }
//
//    }.resume()
//}
