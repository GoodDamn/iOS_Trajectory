//
//  Network.swift
//  iOS_Trajectory
//
//  Created by Cell on 18.02.2023.
//

import UIKit;

class NetworkUtilities{
    
    private static let TAG = "Network:";
    
    public static func downloadFile(httpUrl:String, completion: @escaping ((Data)->Void)) -> Void {
        
        guard let url = URL(string: httpUrl) else {
            print(TAG, "Invalid URL string!");
            return;
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: {
            data,response, error in
           
            print(self.TAG, "Dowloading is comoleted. Response: ",response);
            
            guard let data = data else {
                print(self.TAG, "Error when dowloading a data! Error:", error);
                return;
            }
            
            DispatchQueue.main.async {
                completion(data);
            }
        }).resume();
    }
}
