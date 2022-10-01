//
//  BackGroundView.swift
//  Weather
//
//  Created by Fábio Pontes on 01/10/2022.
//

import SwiftUI

struct BackGroundView: View {
    var tooColor: Color
    var bottonColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [tooColor, bottonColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
}

struct BackGroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackGroundView(tooColor: .blue, bottonColor: Color("lightBlue"))
    }
}
