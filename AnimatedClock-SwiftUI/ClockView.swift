//
//  ClockView.swift
//  AnimatedClock-SwiftUI
//
//  Created by Jordan Christensen on 10/23/20.
//

import SwiftUI

struct ClockView: View {
    private typealias ClockData = (rotation: Angle, xOffset: CGFloat, yOffset: CGFloat)
    
    @State var color: Color
    
    @State private var secondData: ClockData = (.zero, 0, 0)
    @State private var minuteData: ClockData = (.zero, 0, 0)
    @State private var hourData:   ClockData = (.zero, 0, 0)
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let secondWidth: CGFloat = 4
    private let minuteWidth: CGFloat = 6
    private let hourWidth:   CGFloat = 8
    
    private let secondMult: CGFloat = 0.9
    private let minuteMult: CGFloat = 0.8
    private let hourMult:   CGFloat = 0.7
    
    var body: some View {
        GeometryReader { geometry in
            
            // Clock
            ZStack {
                
                // Boundry
                Circle()
                    .foregroundColor(color)
                Circle()
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.95)
                
                
                // Second hand
                RoundedRectangle(cornerRadius: secondWidth / 2)
                    .foregroundColor(color)
                    .frame(width: secondWidth, height: geometry.size.width * secondMult / 2)
                    .offset(x: secondData.xOffset, y: secondData.yOffset)
                    .rotationEffect(secondData.rotation)
                
                // Minute hand
                RoundedRectangle(cornerRadius: minuteWidth / 2)
                    .foregroundColor(color)
                    .frame(width: minuteWidth, height: geometry.size.width * minuteMult / 2)
                    .offset(x: minuteData.xOffset, y: minuteData.yOffset)
                    .rotationEffect(minuteData.rotation)
                
                // Hour hand
                RoundedRectangle(cornerRadius: hourWidth / 2)
                    .foregroundColor(color)
                    .frame(width: hourWidth, height: geometry.size.width * hourMult / 2)
                    .offset(x: hourData.xOffset, y: hourData.yOffset)
                    .rotationEffect(hourData.rotation)
            }
            
        }
        .padding()
    }
    
    private func angle(from progress: CGFloat) -> Angle {
        return Angle(radians: Double(.pi * 2 * progress))
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(color: .red)
    }
}
