//
//  WeatherForecastView.swift
//  Weather
//
//  Created by İhsan TOPALOĞLU on 8/3/21.
//

import SwiftUI

struct WeatherForecastView: View {
    // TODO: Switch to an environment variable for the dark mode preference.
    @State private var isDarkModeOn = false
    @State private var forecast = WeatherData.example
    
    var body: some View {
        ZStack {
            BackgroundGradientView(turnOnDarkMode: isDarkModeOn)
            
            VStack {
                LocationNameView(locationName: forecast.locationName)
                
                TodaysWeatherView(imageName: forecast.today.imageName, temperature: forecast.today.temperature)
                                
                HStack(spacing: 20) {
                    ForEach(forecast.future, id: \.day) {
                        ForecastDayView(dayOfTheWeek: $0.day, imageName: $0.imageName, temperature: $0.temperature)
                    }
                }
                
                Spacer()
                
                AppearanceButtonView(turnOnDarkMode: $isDarkModeOn)
                
                Spacer()
            }
        }
    }
}

private struct WeatherData {
    let locationName: String
    
    let today: Forecast
    
    let future: [Forecast]
    
    struct Forecast {
        let day: String
        let imageName: String
        let temperature: Int
    }
    
    static let example = WeatherData(
        locationName: "Cupertino, CA",
        today: Forecast(day: "SUN", imageName: "cloud.sun.fill", temperature: 72),
        future: [
            Forecast(day: "MON", imageName: "cloud.sun.fill", temperature: 72),
            Forecast(day: "TUE", imageName: "cloud.fill", temperature: 70),
            Forecast(day: "WED", imageName: "cloud.sun.fill", temperature: 72),
            Forecast(day: "THU", imageName: "sun.max.fill", temperature: 74),
            Forecast(day: "FRI", imageName: "sun.max.fill", temperature: 78),
        ]
    )
}

private struct BackgroundGradientView: View {
    var turnOnDarkMode: Bool = false
    
    var body: some View {
        let topLeading = turnOnDarkMode ? Color.black : .blue
        let bottomTrailing = turnOnDarkMode ? Color.gray : Color(.sRGB, red: 0.5, green: 0.7, blue: 1)
        
        LinearGradient(gradient: Gradient(colors: [topLeading, bottomTrailing]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

private struct LocationNameView: View {
    var locationName: String
    
    var body: some View {
        Text(locationName)
            .font(.system(size: 32, weight: .medium))
            .foregroundColor(.white)
            .padding()
    }
}

private struct TodaysWeatherView: View {
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}

private struct ForecastDayView: View {
    var dayOfTheWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfTheWeek)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

private struct AppearanceButtonView: View {
    @Binding var turnOnDarkMode: Bool
    
    var body: some View {
        let title = turnOnDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode"
        let textColor = turnOnDarkMode ? Color.white : .blue
        let buttonColor = turnOnDarkMode ? Color.gray : .white
        
        Button {
            turnOnDarkMode.toggle()
        } label: {
            Text(title)
                .frame(width: 280, height: 50)
                .background(buttonColor)
                .foregroundColor(textColor)
                .font(.system(size: 20, weight: .medium))
                .cornerRadius(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherForecastView()
    }
}
