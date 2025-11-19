//
//  LoadingAnimation.swift
//  WeatherApp
//
//  Created by Akshat Srivastava on 18/11/25.
//

import SwiftUI
import DotLottie

struct LoadingAnimation: View {
    var body: some View {
        DotLottieAnimation(fileName: "LoadingCircle", config: AnimationConfig(autoplay: true, loop: true)).view()
            .clipped()
            .frame(width: 200, height: 200)
    }
}
struct LoadingOverlay: ViewModifier {
    let isPresented: Bool

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                Color.white.opacity(0.8)
                    .ignoresSafeArea()

                LoadingAnimation()
            }
        }
    }
}

extension View {
    func showLoadingAnimation(_ isPresented: Bool) -> some View {
        self.modifier(LoadingOverlay(isPresented: isPresented))
    }
}

//#Preview {
//    LoadingAnimation()
//}
