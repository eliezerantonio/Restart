//
//  OnboardingView.swift
//  Restart
//
//  Created by Eliezer Antonio on 11/10/23.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true

    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTile:  String  = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                // MARK: - HEADER

                Spacer()
                VStack(spacing: 0) {
                    Text(textTile)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTile)
                    
                    Text("""
                    It's not how much we giving how much love we put into giving.
                    """).font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                } //: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)

                // MARK: - CENTER

                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 7))
                        .animation(.easeOut(duration: 1), value: imageOffset)

                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture().onChanged { gesture in
                                if abs(imageOffset.width) <= 150 {
                                    imageOffset = gesture.translation
                                    
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 0
                                        textTile = "Give."
                                    }
                                }
                            }
                            .onEnded {
                                _ in
                                imageOffset = .zero
                                
                                withAnimation(.linear(duration: 0.25)){
                                    indicatorOpacity = 1
                                    textTile = "Share."
                                }
                            }
                        ) //: Gesture
                        .animation(.easeOut(duration: 1), value: imageOffset)
                } //: CENTER
                .overlay(
                 Image(systemName: "arrow.left.and.right.circle")
                .font(.system(size: 44, weight: .ultraLight))
                .foregroundColor(.white)
                .offset(y: 20)
                .opacity(isAnimating ? 1 : 0)
                .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                .opacity(indicatorOpacity)
                ,alignment: .bottom
                )

                Spacer()

                // MARK: FOOTER

                ZStack {
                    // Pasts of custo button

                    // 1. BACKGROUND (static)

                    Capsule().fill(Color.white.opacity(0.2))

                    Capsule().fill(Color.white.opacity(0.2)).padding(8)

                    // 2. CALL-TO-ACTION (STATIC)
                    Text("Get Stared")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold).foregroundColor(.white)
                        .offset(x: 20)
                    // 3. CAPSULE (DYNAMIC WIDTH)

                    HStack {
                        Capsule().fill(Color("ColorRed")).frame(width: buttonOffset + 80)

                        Spacer()
                    }
                    // 4. CRICLE (DRAGGABLE)
                    HStack {
                        ZStack {
                            Circle().fill(Color("ColorRed"))
                            Circle().fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2").font(.system(size: 24, weight: .bold))
                        }.foregroundColor(.white)
                            .frame(width: 80, height: 80, alignment: .center)
                            .offset(x: buttonOffset)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                            buttonOffset = gesture.translation.width
                                        }
                                    }
                                    .onEnded { _ in
                                        withAnimation(Animation.easeInOut(duration: 0.4)) {
                                            if buttonOffset > buttonWidth / 2 {
                                                hapticFeedback.notificationOccurred(.success)
                                                playSound(sound: "chimeup", type: "mp3")
                                                buttonOffset = buttonWidth - 80
                                                isOnboardingViewActive = false
                                                
                                            } else {
                                                buttonOffset = 0
                                                hapticFeedback.notificationOccurred(.warning)
                                            }
                                        }
                                    }
                            ) //: Gesture
                        Spacer()
                    } //: HStack
                } //: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            } //: VSTACK
        } //: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    OnboardingView()
}
