//
//  ClockView.swift
//  AnimatedClock-SwiftUI
//
//  Created by Jordan Christensen on 10/23/20.
//

import SwiftUI

struct ClockView: View {
    private typealias ClockData = (rotation: Angle, xOffset: CGFloat, yOffset: CGFloat)
    
    let secondHandColor: Color?
    let defaultHandColor: Color
    
    @State private var secondAngle: Angle = .zero
    @State private var minuteAngle: Angle = .zero
    @State private var hourAngle: Angle = .zero
    
    private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    private let secondWidth: CGFloat = 4
    private let minuteWidth: CGFloat = 6
    private let hourWidth:   CGFloat = 8
    
    private let secondMult: CGFloat = 0.9
    private let minuteMult: CGFloat = 0.8
    private let hourMult:   CGFloat = 0.7
    
    init(color: Color = .black, secondColor: Color? = nil) {
        self.defaultHandColor = color
        self.secondHandColor = secondColor
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            // Clock
            ZStack {
                
                // Boundry
                Circle()
                    .foregroundColor(defaultHandColor)
                Circle()
                    .foregroundColor(.white)
                    .padding(3)
                
                // Hour hand
                RoundedRectangle(cornerRadius: hourWidth / 2)
                    .foregroundColor(defaultHandColor)
                    .frame(width: hourWidth, height: geometry.size.width * hourMult / 2)
                    .offset(y: -geometry.size.width * hourMult / 4)
                    .rotationEffect(hourAngle)
                
                // Minute hand
                RoundedRectangle(cornerRadius: minuteWidth / 2)
                    .foregroundColor(defaultHandColor)
                    .frame(width: minuteWidth, height: geometry.size.width * minuteMult / 2)
                    .offset(y: -geometry.size.width * minuteMult / 4)
                    .rotationEffect(minuteAngle)
                
                // Second hand
                RoundedRectangle(cornerRadius: secondWidth / 2)
                    .foregroundColor(secondHandColor ?? defaultHandColor)
                    .frame(width: secondWidth, height: geometry.size.width * secondMult / 2)
                    .offset(y: -geometry.size.width * secondMult / 4)
                    .rotationEffect(secondAngle)
            }
            .onReceive(timer) { _ in
                let now = Date(), calendar = Calendar.current
                
                let seconds = CGFloat(calendar.component(.second, from: now))
                let minutes = CGFloat(calendar.component(.minute, from: now)) + seconds / 60
                let hours = CGFloat(calendar.component(.hour, from: now)) + minutes / 60
                
                let sProgress = seconds / 60
                let mProgress = minutes / 60
                let hProgress = (hours > 12 ? hours - 12 : hours) / 12
                
                withAnimation {
                    secondAngle = angle(from: sProgress)
                    minuteAngle = angle(from: mProgress)
                    hourAngle = angle(from: hProgress)
                }
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
        ClockView()
    }
}
