//
//  SearchView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/02.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5)
            HStack {
                TextField("검색할 팀을 임력하세요.", text: $searchText)
                Spacer()
                Button {
                } label: {
                    Text("🔍")
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: .constant(""))
    }
}
