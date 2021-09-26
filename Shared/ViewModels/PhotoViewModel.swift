//
//  PhotoViewModel.swift
//  AvengersAppSwiftUI (iOS)
//
//  Created by David dela Puente on 20/9/21.
//

import SwiftUI
import Combine


class PhotoViewModel : ObservableObject {
    @Published var photo:Image?

    var suscriptor = Set<AnyCancellable>()

    func loadImage(url:String){
        if let urlDownload =  URL(string: url){
        
            URLSession.shared
                .dataTaskPublisher(for: urlDownload)
                .map{
                    UIImage(data: $0.data)
                }
                .map{ image -> Image in
                    if let imagen = image {
                        return Image(uiImage: imagen)
                    }
                    else {
                        return Image("404")
                    }
                }
                .replaceError(with: Image("404"))
                .replaceEmpty(with:Image("404"))
                .receive(on: DispatchQueue.main)
                .sink{
                    self.photo = $0
                }
                .store(in: &suscriptor)
        }
    }

}

