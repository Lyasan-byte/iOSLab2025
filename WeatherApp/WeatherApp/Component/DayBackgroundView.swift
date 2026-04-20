//
//  DayBackgroundView.swift
//  WeatherApp
//
//  Created by Ляйсан
//

import SwiftUI

struct DayBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.dayDark, .dayMiddle, .dayLight], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            Cloud(color: .cloudDark, width: 360, height: 100, positionX: 60, positionY: 170)
            Cloud(color: .cloudLight, width: 360, height: 100, positionX: 150, positionY: 120)
            Cloud(color: .cloudExtraLight.opacity(0.7), width: 360, height: 100, positionX: 220, positionY: 180)
            Cloud(color: .cloudDark, width: 360, height: 100, positionX: 320, positionY: 230)
            Cloud(color: .cloudDark, width: 360, height: 100, positionX: 370, positionY: 30)
        }
        .ignoresSafeArea()
    }
    
    private struct Cloud: View {
        let color: Color
        let width: CGFloat
        let height: CGFloat
        let positionX: CGFloat
        let positionY: CGFloat
        
        var body: some View {
            Circle()
                .fill(color)
                .frame(width: width, height: height)
                .blur(radius: 40)
                .position(x: positionX, y: positionY)
        }
    }
}

#Preview {
    DayBackgroundView()
}
