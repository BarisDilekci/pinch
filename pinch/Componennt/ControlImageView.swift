//
//  ControlImageView.swift
//  pinch
//
//  Created by Barış Dilekçi on 7.07.2024.
//

import SwiftUI

struct ControlImageView: View {
    //MARK: - PROPERTIES
    let icon : String
    
    //MARK: - LIFE CYCLE
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

#Preview {
    ControlImageView(icon: "minus.magnifyingglass")
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
}
