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
            print(TAG, "Invalid URL string!");
            return;
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: {
            data,response, error in
           
            print(TAG, "Dowloading is comoleted. Response:", response);
            
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
            
            DispatchQueue.main.async {
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
}
