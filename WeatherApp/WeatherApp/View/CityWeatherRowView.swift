//
//  CityWeatherRowView.swift
//  WeatherApp
//
//  Created by Ляйсан
//

import SwiftUI

struct CityWeatherRowView: View {
    let cityWeahter: CityWeather
    
    var body: some View {
        HStack {
            cityName
            weatherSymbol
            
            Spacer()
            temperatureLine
            Spacer()
            
            degrees
        }
        .foregroundStyle(.white)
        .font(.title3)
        .fontWeight(.medium)
        .padding(.vertical, 10)
        .padding(.horizontal)
        .frame(height: 40)
    }
    
    private var cityName: some View {
        Text(cityWeahter.city.name)
            .font(.headline)
            .frame(minWidth: 90, alignment: .leading)
    }
    
    private var weatherSymbol: some View {
        Image(systemName: cityWeahter.weather.weatherSymbol)
            .symbolRenderingMode(.palette)
            .foregroundStyle(cityWeahter.weather.weatherSymbolColors[0], cityWeahter.weather.weatherSymbolColors[1])
    }
    
    private var temperatureLine: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(LinearGradient(colors: cityWeahter.weather.tempratureColors, startPoint: .leading, endPoint: .trailing))
            .frame(width: 100, height: 3)
    }
    
    private var degrees: some View {
        HStack(spacing: 1) {
            Text("\(Int(cityWeahter.weather.temperature2m.rounded()))")
            Text("°")
        }
        .frame(minWidth: 55, alignment: .trailing)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        CityWeatherRowView(cityWeahter: CityWeather(city: City(name: "Kazan", latitude: 0, longitude: 0), weather: CurrentWeather(temperature2m: 0, weatherCode: 77)))
            .padding(.horizontal)
    }
}
