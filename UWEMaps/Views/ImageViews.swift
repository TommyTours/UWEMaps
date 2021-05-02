//
//  ImageViews.swift
//  UWEMaps
//
//  Created by Tom Clifford on 02/05/2021.
//

import SwiftUI

struct ImageFromURLView: View
{
    @ObservedObject var urlImageLoader: ImageLoader
    
    init(_ url: String)
    {
        urlImageLoader = ImageLoader(imageURL: url)
    }
    var body: some View
    {
        Image(uiImage: UIImage(data: self.urlImageLoader.image) ?? UIImage())
            .resizable()
    }
}

struct ImageFromImageKeyView: View
{
    let imageKey: String
    
    var body: some View
    {
        Image(imageKey)
            .resizable()
    }
}

class ImageLoader : ObservableObject
{
    @Published var image = Data()
    
    init(imageURL: String)
    {
        let imageCache = URLCache.shared
        let urlRequest = URLRequest(url: URL(string: imageURL)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
        if let data = imageCache.cachedResponse(for: urlRequest)?.data
        {
            self.image = data
        }
        else
        {
            URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if let data = data, let response = response {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    imageCache.storeCachedResponse(cachedData, for: urlRequest)
                    DispatchQueue.main.async {
                        self.image = data
                    }
                }
            }).resume()
        }
    }
}

//struct ImageViews_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageViews()
//    }
//}
