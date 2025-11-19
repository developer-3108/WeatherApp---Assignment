//
//  WeatherAnimation.swift
//  WeatherApp
//
//  Created by Akshat Srivastava on 18/11/25.
//

import SwiftUI
import DotLottie

struct WeatherAnimation: View {
    var weatherName: String
    var body: some View {
        DotLottieAnimation(fileName: weatherName, config: AnimationConfig(autoplay: true, loop: true)).view()
            .clipped()
            .frame(width: 250, height: 250)
    }
}
//
//#Preview {
//    WeatherAnimation()
//}
