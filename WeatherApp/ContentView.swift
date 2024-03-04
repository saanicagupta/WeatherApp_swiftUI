//
//  ContentView.swift
//  WeatherApp
//
//  Created by Sannica.Gupta on 04/03/24.
//

import SwiftUI

struct ContentView: View {
    @State var isNight = false
    
    var dataModelWeatherSubviews: [WeatherModel] = [
        WeatherModel(day: "TUE",
                     imageWeather: "cloud.sun.fill", degree: 74),
        WeatherModel(day: "WED",
                     imageWeather: "sun.max.fill", degree: 88),
        WeatherModel(day: "THU",
                     imageWeather: "wind.snow", degree: 55),
        WeatherModel(day: "FRI",
                     imageWeather: "sunset.fill", degree: 60),
        WeatherModel(day: "SAT",
                     imageWeather: "snow", degree: 25)
    ]
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            
            VStack {
                MainCityTitleView(city: "Delhi, India")
                MainWeatherView(isNight: isNight,
                                imageWeather: "cloud.sun.fill",
                                degree: 76)
                
                HStack(spacing: 24) {
                    ForEach(0..<dataModelWeatherSubviews.count, id: \.self) { index in
                        WeatherDayView(dataModel: dataModelWeatherSubviews[index])
                    }
                }
                
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time",
                                  textColor: .blue,
                                  backgroundColor: .white)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    var dataModel: WeatherModel
    
    var body: some View {
        VStack {
            Text(dataModel.day)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: dataModel.imageWeather)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(dataModel.degree)°")
                .font(.system(size: 26, weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}


struct BackgroundView: View {
    var isNight: Bool
    var body: some View {
        LinearGradient(
            colors: [isNight ? .black : .blue,
                     isNight ? .gray : Color(UIColor(named: "LightBlue") ?? .blue)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        .ignoresSafeArea()
        
        // simpler alternative for inbuilt gradient
        /*
         ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea()
         */
    }
}

struct MainCityTitleView: View {
    var city: String
    var body: some View {
        Text(city)
            .font(.system(size: 32, weight: .medium))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherView: View {
    var isNight: Bool
    var imageWeather: String
    var degree: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: isNight ? "moon.stars" : imageWeather)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .foregroundStyle(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(degree)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
