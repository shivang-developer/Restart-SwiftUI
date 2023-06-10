//
//  OnboardingView.swift
//  Restart
//
//  Created by Shivang Mishra on 08/06/23.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: PROPERTY
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State var imageOffset: CGSize = .zero
    @State private var isAnimating: Bool = false
    @State private var indicatorOpacity: Double = 1
    @State private var textTitle: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    //MARK: BODY
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            VStack(spacing: 20.0) {
                // MARK: - HEADER
                Spacer()
                VStack(spacing: 0.0) {
                    Text(textTitle)
                        .font(.system(size: 60.0))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    Text("It's not how much we give but how much love we put into giving.")
                        .font(.title3)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                        .foregroundColor(.white)
                } //: HEADER
                .opacity(isAnimating ? 1.0 : 0.0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                // MARK: - CENTER
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .animation(.easeOut(duration: 1), value: imageOffset)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1.0 : 0.0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .animation(.easeOut(duration: 1), value: imageOffset)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                })
                                .onEnded({ gesture in
                                    imageOffset = .zero
                                    indicatorOpacity = 1
                                    textTitle = "Share."
                                })
                        )
                } //: CENTER
                .overlay(alignment: .bottom, content: {
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44.0, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: imageOffset)
                        .opacity(indicatorOpacity)
                })
                Spacer()
                // MARK: - FOOTER
                ZStack {
                    // PARTS OF THE CUSTOM BUTTON
                    //1. BACKGROUND (STATIC)
                    Capsule().fill(Color.white.opacity(0.2))
                    Capsule().fill(Color.white.opacity(0.2)).padding(8.0)
                    //2. CALL-TO-ACTION TEXT (STATIC)
                    Text("Get Started").font(.system(.title3))
                        .foregroundColor(.white).fontWeight(.bold)
                        .offset(x: 20)
                    //3. CAPSULE (DYNAMIC WIDTH)
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    //4. CIRCLE(DRAGGABLE)
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15)).padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0  && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{ gesture in
                                    withAnimation(Animation.easeOut(duration: 1.0)) {
                                        if buttonOffset <= buttonWidth/2 {
                                            buttonOffset = 0
                                        }
                                        else {
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                            playSound(sound: "chimeup", type: "mp3")
                                            hapticFeedback.notificationOccurred(.warning)
                                        }
                                    }
                                }
                        )
                        Spacer()
                    } // : HSTACK
                } // : FOOTER
                .frame(width: buttonWidth,height: 80.0, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1.0 : 0.0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                // MARK: - CENTER
            }
        }.onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
