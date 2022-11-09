//
//  FavoriteButton.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/09.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isCheck: Bool
    var body: some View {
        Button {
            isCheck.toggle()
        } label: {
            Label("Toggle Oauth", systemImage: isCheck ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isCheck ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isCheck: .constant(true))
    }
}
