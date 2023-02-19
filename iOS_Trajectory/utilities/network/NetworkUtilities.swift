//
//  Network.swift
//  iOS_Trajectory
//
//  Created by Cell on 18.02.2023.
//

import UIKit;

class NetworkUtilities{
    
    private static let TAG = "NetworkUtilities:";
    
    public static func downloadFile(
        _ httpUrl:String,
        completion: @escaping ((Data)->Void),
        onFailed: ((Error?) -> Void)?
        ) {
        
        guard let url = URL(string: httpUrl) else {
            onFailed?(nil);
            print(TAG, "Invalid URL string!");
            return;
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: {
            data,response, error in
            DispatchQueue.main.async {
                print(TAG, "Dowloading is completed. Response:", response);
                
                if error != nil {
                    print(TAG, "Some error was occured:", error);
                    onFailed?(error);
                    return;
                }
                
                guard let data = data else {
                    print(TAG, "Error while dowloading a data! Message:", error);
                    onFailed?(error);
                    return;
                }
                
                
                completion(data);
            }
        }).resume();
        
    }
    
    public static func downloadFile(
        _ httpUrl:String,
        completion: @escaping ((Data)->Void)
        ) {
        downloadFile(httpUrl,
                     completion: completion,
                     onFailed: nil);
    }
    
    public static func getJSONFile<T : Decodable>(
        _ url: String,
        completion: @escaping ((T)->Void),
        onFailed: @escaping ((String)->Void)
        ) {
        
        downloadFile(
            url,
            completion: {
                data in
                
                do {
                    let json = try JSONDecoder().decode(T.self, from: data);
                    completion(json);
                } catch {
                    
                    onFailed("При обработке данных, произошла ошибка");
                    
                    print(self.TAG, "Error: JSON-parsing failed! Message:",error);
                }
            }, onFailed: {
                error in
                onFailed("При получении данных из сети, произошла ошибка");
            }
        );
    }
}
