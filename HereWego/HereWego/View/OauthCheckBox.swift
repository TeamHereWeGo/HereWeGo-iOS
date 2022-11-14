//
//  OauthCheckBox.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/09.
//

import SwiftUI

struct OauthCheckBox: View {
    @Binding var isChecked: Bool
    var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            Label("Toggle Oauth", systemImage: isChecked ? "checkmark.square" : "square")
                .labelStyle(.iconOnly)
        }
    }
}

struct OauthCheckBox_Previews: PreviewProvider {
    static var previews: some View {
        OauthCheckBox(isChecked: .constant(true))
    }
}
