//
//  MenuViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 2/8/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {


    @IBOutlet weak var Hometableview: UITableView!
    
    var menu = ["Home","Order","Table","Bill","History"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return menu.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tableView.dequeueReusableCell(withIdentifier: menu[indexPath.row])! as UITableViewCell
        data.layer.cornerRadius = 15
        data.layer.borderWidth = 0.5
        data.textLabel?.text = menu[indexPath.row]
        
        return data
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
