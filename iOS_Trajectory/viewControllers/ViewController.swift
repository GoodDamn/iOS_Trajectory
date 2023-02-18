//
//  ViewController.swift
//  iOS_Trajectory
//
//  Created by Cell on 18.02.2023.
//

import UIKit;

class ViewController: UIViewController {

    @IBOutlet weak var socials_tableView:UITableView!;
    
    private final let SOCIALS_ELEMENT_CELL_ID = "socials_element";
    private final let TAG = "ViewController:";
    private final let HTTP_URL_JSON = "https://mobile-olympiad-trajectory.hb.bizmrg.com/semi-final-data.json";
    private final let VIEW_CONTROLLER_FULL_INFO_ID = "full_Info";
    
    private var items:[ItemSocial]!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        NetworkUtilities.downloadFile(httpUrl: HTTP_URL_JSON, completion: { [self]
            data in
            
            do {
                items = try JSONDecoder().decode(ItemsArray.self, from: data).items;
                
                socials_tableView.delegate = self;
                socials_tableView.dataSource = self;
                socials_tableView.reloadData();
            } catch {
                print(TAG, "Error: JSON-parsing failed! Message:",error);
            }
            
        });
        
    }

    
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(TAG, "Move to Full information view controller");
        
        let cell = tableView.cellForRow(at: indexPath) as! SocialUITableViewCell;
        
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: VIEW_CONTROLLER_FULL_INFO_ID) as! FullInfoViewController;
        
        let data:ItemSocial = items[indexPath.row];
        
        viewController.setItemData(input: ItemData(
                                   image_icon: cell.imageView_icon.image,
                                    name: data.name,
                                    description: data.description,
                                    link: data.service_url));
        
        
        navigationController?.pushViewController(viewController, animated: true);
    }
    
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SOCIALS_ELEMENT_CELL_ID) as! SocialUITableViewCell;
        
        let socialInfo: ItemSocial = items[indexPath.row];
        
        cell.label_name.text = socialInfo.name;
        
        NetworkUtilities.downloadFile(httpUrl: socialInfo.icon_url, completion: {
            data in
            cell.imageView_icon.image = UIImage(data: data);
        });
        
        return cell;
    }
}
