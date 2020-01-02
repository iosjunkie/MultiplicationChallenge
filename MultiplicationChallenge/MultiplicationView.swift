//
//  NumberView.swift
//  Challenge2
//
//  Created by Ale Mohamad on 02/11/2019.
//  Copyright © 2019 Ale Mohamad. All rights reserved.
//

import SwiftUI

struct MultiplicationView: View {
    var number: Int
    @State private var tapped = false
    @State private var origin:CGFloat = 1
    var completion: (_ pos: Int) -> ()

    var body: some View {
        VStack {
            Button(action: {
                self.tapped.toggle()
                self.origin += 0.4
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.tapped.toggle()
                    self.origin = 1
                }
                self.completion(self.number)
            }) {
                VStack {
                    Image("character_\(number)")
                        .renderingMode(.original)
                    Text("\(number)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 20.0, alignment: .center)
                }
            .scaleEffect(origin)
            .animation(Animation.linear(duration: 0.1).repeatCount(tapped ? 5 : 0))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
