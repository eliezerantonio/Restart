//
//  ContentView.swift
//  Restart
//
//  Created by Eliezer Antonio on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive : Bool = true
    
    var body: some View {
        ZStack {
     
            if isOnboardingViewActive{
                OnboardingView()
            }else{
                HomeView()
            }
        }
       
    }
}

#Preview {
    ContentView()
}
