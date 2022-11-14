//
//  ProfileButton.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/09.
//

import SwiftUI

struct ProfileButton: View {
    @State private var showingProfile = false
    @Binding var isLogined: Bool
    @Binding var userName: String
    @Binding var password: String
    var body: some View {
        Button {
            showingProfile.toggle()
        } label: {
            Label("User Profile", systemImage: "person.crop.circle")
                .foregroundColor(.black)
                .labelStyle(.iconOnly)
        }
        .sheet(isPresented: $showingProfile) {
            ProfileUser(isLogined: $isLogined, userName: self.$userName, password: self.$password)
        }
    }
}

struct ProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButton(isLogined: .constant(true),userName: .constant("jmtkd9196"), password: .constant("dlrudtn1234"))
    }
}
