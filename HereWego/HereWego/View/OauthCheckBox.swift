//
//  OauthCheckBox.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/09.
//

import SwiftUI

struct OauthCheckBox: View {
    @Binding var isCheck: Bool
    var body: some View {
        Button {
            isCheck.toggle()
        } label: {
            Label("Toggle Oauth", systemImage: isCheck ? "checkmark.square" : "square")
                .labelStyle(.iconOnly)
        }
    }
}

struct OauthCheckBox_Previews: PreviewProvider {
    static var previews: some View {
        OauthCheckBox(isCheck: .constant(true))
    }
}
