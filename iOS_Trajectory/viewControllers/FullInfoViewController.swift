//
//  FullInfoViewController.swift
//  iOS_Trajectory
//
//  Created by Cell on 18.02.2023.
//

import UIKit;

class FullInfoViewController: UIViewController{
    
    @IBOutlet weak var imageView_icon: UIImageView!;
    @IBOutlet weak var label_name: UILabel!;
    @IBOutlet weak var label_description: UILabel!;
    @IBOutlet weak var textView_link: UITextView!;
    
    private var itemData:ServiceInfo? = nil;
    
    public func setItemData(_ input: ServiceInfo){
        itemData = input;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        guard let itemData = itemData else {
            
            Utilities.showErrorAlertDialog(
                self,
                message: "При обработке данных, произошла ошибка.",
                okAction: {
                    alertAction in
                    self.navigationController?.popViewController(animated: true);
                },
                retryAction: nil);
            return;
        }
        
        title = itemData.name;
        
        imageView_icon.image = itemData.image_icon;
        label_name.text = itemData.name;
        label_description.text = itemData.description;
        textView_link.text = itemData.link;
        
    }
}
