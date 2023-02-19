//
//  Utilities.swift
//  iOS_Trajectory
//
//  Created by Cell on 19.02.2023.
//

import UIKit;

class Utilities{
    
    public static func showErrorAlertDialog(
        _ vc: UIViewController,
        message: String?,
        okAction: ((UIAlertAction) -> Void)?,
        retryAction: ((UIAlertAction)->Void)?
    ) {
        
        let alertController = UIAlertController(
                                title: "Ошибка",
                                message: message,
                                preferredStyle: .alert);
        
        let actionOk = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: okAction);
        
        let actionRetry = UIAlertAction(title: "Обновить",
                                        style: .default,
                                        handler: retryAction);
        
        alertController.addAction(actionOk);
        alertController.addAction(actionRetry)
        
        vc.present(alertController, animated: true, completion: nil);
    }
    
}
