//
//  BackgroundView.swift
//  WeatherApp
//
//  Created by Akshat Srivastava on 18/11/25.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [Color.init(red: 29/255, green: 32/255, blue: 51/255), Color.black], startPoint: .topTrailing, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

// MARK: - Extension view so backgroundColor() can be used everywhere which makes this scalable and modulor
extension View {
    func backgroundColor() -> some View {
        ZStack {
            BackgroundView()
            self
        }
    }
}

//#Preview {
//    BackgroundView()
//}
