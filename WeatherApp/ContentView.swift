//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ivan Valero on 27/10/2021.
//

import SwiftUI


// key a4437bf3fea91f76f7b038a30af27952

// endpoint: api.openweathermap.org/data/2.5/weather?q=barcelona&appid=a4437bf3fea91f76f7b038a30af27952&units=metric&lang=es

struct ContentView: View {
    
    @StateObject var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            VStack {
//  anterior              Text(weatherViewModel.responseWeatherDataModel?.city ?? "No city")
                // nuevo
                // accedo al viewModel, despues al nuevo Model por medio del weatherModel y luego city
                Text(weatherViewModel.weatherModel.city)
                    .fontWeight(.semibold)
                    .font(.system(size: 70))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 100)
//                    .task {
//                        await weatherViewModel.getWeather(city: "Córdoba")
//                    }
                
                Text(weatherViewModel.weatherModel.description)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                HStack {
                    if let iconURL = weatherViewModel.weatherModel.iconURL,
                       let url = URL(string: "http://openweathermap.org/img/wn/\(iconURL)@2x.png") {
                        AsyncImage(url: url) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Text(weatherViewModel.weatherModel.currentTempetarute)
                        .fontWeight(.semibold)
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                }
                .padding(.top, -20)
                HStack(spacing: 1) {
                    Image(systemName:"thermometer.snowflake")
                        .renderingMode(.original)
                    Text(weatherViewModel.weatherModel.minTemperature)
                        .padding(.trailing , 8)
                    Image(systemName:"thermometer.sun.fill")
                        .renderingMode(.original)
                    Text(weatherViewModel.weatherModel.maxTemperature)
                }
                .foregroundColor(.white)
                .font(.system(size: 22))
                Divider()
                    .foregroundColor(.white)
                    .padding()
                HStack(spacing: 30) {
                    VStack {
                        Image(systemName: "sunrise.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 40, height: 30)
                        Text(weatherViewModel.weatherModel.sunrise, style: .time)
                            .foregroundColor(.white)
                    }
                    VStack {
                        Image(systemName: "sunset.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 40, height: 30)
                        Text(weatherViewModel.weatherModel.sunset, style: .time)
                            .foregroundColor(.white)
                    }
                }
                Divider()
                    .foregroundColor(.white)
                    .padding()
                HStack (spacing: 1){
                    Image(systemName:"aqi.medium")
                        //.foregroundColor(.white)
                    Text(weatherViewModel.weatherModel.humidity)
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .padding(.vertical, 12)
                }
                Spacer()
            }
            .padding(.top, 32)
        }
        .edgesIgnoringSafeArea(.all)
//        .frame(width: 500, height: 900)
        .background(LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: .topLeading, endPoint: .bottomTrailing))
        .task {
            await weatherViewModel.getWeather(city: "Cordoba")
        }
     
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
