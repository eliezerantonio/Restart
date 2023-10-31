//
//  HomeView.swift
//  Restart
//
//  Created by Eliezer Antonio on 11/10/23.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    

    var body: some View {
        VStack(spacing: 20) {
            // MARK: - HEADER

            Spacer()
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)

                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(
                        Animation.easeInOut(duration: 4)
                            .repeatForever()
                        , value: isAnimating
                    )
            }

            // MARK: - CENTER

            Text("The time thath leads to mastery is dependent on the intensidade of our focus")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()

            // MARK: - FOOTER

            Spacer()
            Button(action: {
                withAnimation {
                    playSound(sound: "success", type: "m4a")
                    isOnboardingViewActive = true
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")

                Text("Restart")
                    .font(.system(.title3, design: .rounded)).fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
            } //: BUTTON
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } //: VSTACK
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        }).padding()
    }
}

#Preview {
    HomeView()
}
