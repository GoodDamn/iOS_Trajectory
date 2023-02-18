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
    
    private var itemData:ItemData!;
    
    public func setItemData(input: ItemData){
        itemData = input;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        title = itemData.name;
        
        imageView_icon.image = itemData.image_icon;
        label_name.text = itemData.name;
        label_description.text = itemData.description;
        textView_link.text = itemData.link;
        
    }
}
