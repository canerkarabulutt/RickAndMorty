//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 18.12.2023.
//

import Foundation

class RMImageLoader {
    static let shared = RMImageLoader()
    
    //MARK: - NSCache yöntemi önbellek mekanizması eklemesi ve bu önbellek mekanizmasını kullanarak daha önce indirilmiş olan resim verilerini saklamasıdır.  Normal hali her seferinde aynı URL için yeni bir indirme işlemi yapar.İlk kod, aynı resimlerin tekrar tekrar indirilmesini önleyerek performans avantajı sağlayabilir. Ancak, bu önbellek mekanizması aynı zamanda bellek kullanımını artırabilir ve gereksiz veri birikimine neden olabilir. İkinci kod ise her zaman taze verileri indirir, ancak bellek kullanımını daha etkili bir şekilde yönetir.Eğer resimlerin sık sık değiştiği bir durum varsa veya resimlerin sürekli güncellenmesi gerekiyorsa, NSCache kullanmamak daha performanslıdır.
    
 //   private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    /// Get image content with URI
    /// - Parameters:
    /// - url: Source url
    /// - completion:Callback
    
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data,Error>) -> Void) {
     /*   let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data)) //NSData == Data | NSString == String
            return
        } */
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
          /*  let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key) */
            completion(.success(data))
        }
        task.resume()
    }
}
