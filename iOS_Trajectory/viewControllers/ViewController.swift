//
//  ViewController.swift
//  iOS_Trajectory
//
//  Created by Cell on 18.02.2023.
//

import UIKit;

class ViewController: UIViewController {

    @IBOutlet weak var socials_tableView:UITableView!;
    
    private final let TAG = "ViewController:";
    private final let HTTPS_URL_JSON = "https://mobile-olympiad-trajectory.hb.bizmrg.com/semi-final-data.json";
    
    private var items:[Services]!;
    
    private func fetchData(_ servicesArray: ServicesArray) {
        self.items = servicesArray.items;
        self.socials_tableView.delegate = self;
        self.socials_tableView.dataSource = self;
        self.socials_tableView.reloadData();
    }
    
    private func jsonObserve(_ url:String){
        NetworkUtilities.downloadJSONFile(
            url,
            completion: {
                (servicesArray: ServicesArray?) in
                self.fetchData(servicesArray!);
            }, onFailed: {
                message in
                self.errorAlert(message);
            });
    }
    
    private func errorAlert(_ message: String?){
        Utilities.showErrorAlertDialog(
            self,
            message: message,
            okAction: nil,
            retryAction: {
                alertAction in
                self.jsonObserve(self.HTTPS_URL_JSON);
            });
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();

        jsonObserve(self.HTTPS_URL_JSON);
    }
    
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(TAG, "Move to Full information view controller");
        
        let cell = tableView.cellForRow(at: indexPath) as! ServiceUITableViewCell;
        
        let viewController = Utilities.getFullInfoViewController()!;
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Utilities.ID_SERVICES_ELEMENT_CELL)
            as! ServiceUITableViewCell;
        
        let serviceInfo = items[indexPath.row];
        
        cell.label_name.text = serviceInfo.name;
        
        NetworkUtilities.downloadImage(
            serviceInfo.icon_url,
            completion: {
                image in
                cell.imageView_icon.image = image;
            },
            onFailed: {
                errorMessage in
                Utilities.showErrorAlertDialog(
                    self,
                    message: "?????? ?????????????????? ??????????????????????, ?????????????????? ????????????",
                    okAction: nil,
                    retryAction: nil);
            });
        
        return cell;
    }
}
