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
    private final let HTTPS_URL_JSON = "https://mobile-olympiad-trajectory.hb.bizmrg.com/semi-final-data.json";
    private final let VIEW_CONTROLLER_FULL_INFO_ID = "full_Info";
    
    private var items:[Services]!;
    
    private func fetchData(data: Data) throws {
        self.items = try JSONDecoder().decode(ServicesArray.self, from: data).items;
        self.socials_tableView.delegate = self;
        self.socials_tableView.dataSource = self;
        self.socials_tableView.reloadData();
    }
    
    private func getJSONFile(_ url: String) {
        NetworkUtilities.downloadFile(
            url,
            completion: { [weak self]
                data in
                
                guard let self = self else{
                    print(self?.TAG, "May be it was deallocated ?");
                    return;
                }
                
                do {
                    try self.fetchData(data: data);
                } catch {
                    
                    Utilities.showErrorAlertDialog(
                        self,
                        message: "При обработке данных, произошла ошибка",
                        okAction: nil,
                        retryAction: {
                            alertAction in
                            self.getJSONFile(self.HTTPS_URL_JSON);
                        });
                    
                    print(self.TAG, "Error: JSON-parsing failed! Message:",error);
                }
            }, onFailed: {
                error in
                
                Utilities.showErrorAlertDialog(
                    self,
                    message: "При получении данных из сети, произошла ошибка",
                    okAction: nil,
                    retryAction: {
                        alertAction in
                        self.getJSONFile(self.HTTPS_URL_JSON);
                    });
            });
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();

        getJSONFile(HTTPS_URL_JSON);
    }
    
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(TAG, "Move to Full information view controller");
        
        let cell = tableView.cellForRow(at: indexPath) as! SocialUITableViewCell;
        
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: VIEW_CONTROLLER_FULL_INFO_ID) as! FullInfoViewController;
        
        let data = items[indexPath.row];
        
        viewController.setItemData(ServiceInfo(
            image_icon: cell.imageView_icon.image,
            name: data.name,
            description: data.description,
            link: data.service_url)
        );
        
        
        navigationController?.pushViewController(viewController, animated: true);
    }
    
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SOCIALS_ELEMENT_CELL_ID)
                    as! SocialUITableViewCell;
        
        let socialInfo = items[indexPath.row];
        
        cell.label_name.text = socialInfo.name;
        
        NetworkUtilities.downloadFile(socialInfo.icon_url, completion: {
            data in
            cell.imageView_icon.image = UIImage(data: data);
        });
        
        return cell;
    }
}
