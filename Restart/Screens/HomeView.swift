//
//  HomeView.swift
//  Restart
//
//  Created by Shivang Mishra on 08/06/23.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 20.0) {
            // MARK:- HEADER
            Spacer()
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(
                        .easeInOut(duration: 4)
                        .repeatForever(),
                        value: isAnimating)
            }
            // MARK:- CENTER
            Text("The time that leads to mastery is dependent on our focus")
                .font(.system(.title3))
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            // MARK:- FOOTER
            Spacer()
            Button {
                withAnimation {
                    isOnboardingViewActive = true
                    playSound(sound: "success", type: "m4a")
                }
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded, weight: .bold))
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                isAnimating = true
            })
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
