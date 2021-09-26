//
//  LoadingView.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 20/9/21.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isLoading = false
    
    var body: some View {
        ZStack{
            Color.black
            .ignoresSafeArea()
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150, alignment: .center)
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
                .frame(width: 150, height: 150)
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color("RedMarvel"), lineWidth: 7)
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0)) .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear(){
                    self.isLoading = true
                }
                .onDisappear{
                    self.isLoading = false
                }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
