//
//  FoodViewController.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 22/7/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class FoodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
     @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var OpenMenu: UIBarButtonItem!
    
//    var foods = [
//        Food(imageName: "kraprao", foodName: "กระเพรา", foodPrice: 40)
//    ]
    
     //let storageRef = Storage.storage().reference().child("Food")
    
    @IBOutlet weak var searchFood: UISearchBar!
    
    var categoryName : String!
    var categoryId : String!
    var countfood : Int!
    
    var foodimages : NSURL!
    
    var newFood = Food()
    
    var foods: [FoodItem] = []
    var filteredfoods: [FoodItem] = []
    let ref = Database.database().reference(withPath: "Food-items")
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.navigationItem.title = categoryName;
        
        searchController.searchResultsUpdater = self as! UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "ค้นหาเมนู"
        navigationItem.searchController = searchController
        definesPresentationContext = false
        
        //searchController = nil
        
        
        
        searchController.searchBar.scopeButtonTitles = ["อาหารตามสั่ง","ยำ","ตำ","ทอด,เผา,ย่าง","เครื่องเคียง","ของหวาน"]
        searchController.searchBar.delegate = self
        
        // Setup the search footer
        
        searchController.searchBar.isHidden = true
      
       // OpenMenu.target = self.revealViewController()
        //OpenMenu.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        ref.child("อาหาร").queryOrdered(byChild: "idcategory").queryEqual(toValue: categoryId).observe(.value, with: { snapshot in
            var newFoods: [FoodItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let foodItem = FoodItem(snapshot: snapshot) {
                    newFoods.append(foodItem)
                }
            }
            self.foods = newFoods
            self.foods.sort { $0.name < $1.name}
            
            self.tableView.reloadData()
            
        })
        
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filteredfoods.count
        }

        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell") as! FoodTableViewCell
        
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor(red:29/255, green:30/255, blue:32/255, alpha: 1).cgColor
        
        cell.imageViewFood.layer.cornerRadius = 15
        cell.imageViewFood.layer.borderWidth = 2
        cell.imageViewFood.layer.borderColor = UIColor(red:29/255, green:30/255, blue:32/255, alpha: 1).cgColor
        
        let foodItem = foods[indexPath.row]
        
        let food: FoodItem
        if isFiltering() {
            food = filteredfoods[indexPath.row]
        } else {
            food = foods[indexPath.row]
        }
        
        if foodItem.status == "off" {
                 cell.contentView.alpha = 0.4
             }else {
                   cell.contentView.alpha = 1
             }
        
        cell.lblFoodName?.text = foodItem.name
        cell.lblFoodPrice?.text = foodItem.price
        
        
        let imageRef = Storage.storage().reference().child("Food").child(foodItem.name.lowercased()+".jpg")
        imageRef.getData(maxSize: 100*1024*1024, completion: { (data, error) -> Void  in
            
            

            if error == nil {
                print("Data")
                print(data)
                  cell.imageViewFood?.image = UIImage(data: data!)
                
             //print(error?.localizedDescription)
                
            } else {
               
                 print("error")
              //  print(data)
                print(error?.localizedDescription)
              
            }
            
        })
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newfood = segue.destination as? NewFoodViewController
        newfood?.category = categoryName
         newfood?.categoryID = categoryId
        newfood?.countfood = foods.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //  let showFood = storyboard?.instantiateInitialViewController(withIdentifier: "show") as! DetailFoodViewController
        
        var showFood = storyboard?.instantiateViewController(withIdentifier: "show") as! DetailFoodViewController
        
        showFood.name =  foods[indexPath.row].name
        showFood.price = foods[indexPath.row].price
        showFood.img = foods[indexPath.row].foodimage
        showFood.category = categoryName

        self.navigationController?.pushViewController(showFood, animated: false)
       
        
     //   self.present(showFood, animated: true, completion: nil)
    }
    
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let foodItem = foods[indexPath.row]
//            foodItem.ref?.removeValue()
//        }
//    }
    
    var namestatus: String?
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if self.foods[indexPath.row].status == "off"{
            namestatus = "on"
        }else {
            namestatus = "off"
        }
        
        let statusButton = UITableViewRowAction(style: .default, title: namestatus) { (action, indexPath) in
            let foodItem = self.foods[indexPath.row]
            self.ref.child("อาหาร").child(foodItem.foodid).updateChildValues(["status": self.namestatus])
            tableView.reloadRows(at: [indexPath], with: .none)
            print("Opennnn ",self.namestatus)
        }
        
//         let editButton = UITableViewRowAction(style: .default, title: "แก้ไข") { (action, indexPath) in
//                self.update(row: indexPath)
//        }
//
       
        statusButton.backgroundColor = #colorLiteral(red: 0.9396336079, green: 0.8933145404, blue: 0.1257261634, alpha: 1)
        return [statusButton]
    }
    
    var match: Int?
   /*   func update(row: IndexPath){
                   let alert = UIAlertController(title: "Edit Category", message: nil, preferredStyle: .alert)
                  
                        let alert2 = UIAlertController(title: "ลองใหม่อีกครั้ง", message: "ข้อมูลไม่ถูกต้อง", preferredStyle: .alert)
                      
                         let alert3 = UIAlertController(title: "แก้ไขเรียบร้อย", message: nil, preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Cancel",
                                                              style: .cancel)
                        let OkAction = UIAlertAction(title: "Ok",
                                                                   style: .cancel)
                        
                        alert.addTextField { (textField) in
                            textField.text = ""
                        }
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                           
                            switch Int((textField?.text!)!) {
                                   case nil:
                                    for i in self.foods {
                                                     if i.name == textField?.text {
                                                         self.match = 1
                                                         break
                                                     } else {
                                                       //  print("Text field: \(name)")
                                                         self.match = 0
                                                     }
                                                                   
                                                 }
                                   default:
                                       self.match = 1
                                   }

                        
                            
                            if self.match == 1 || (textField!.text == "") {
                                  self.present(alert2, animated: true, completion: nil)
                            }else {
                                 self.present(alert3, animated: true, completion: nil)
                            }
                                
                            self.tableView.reloadRows(at: [row], with: .none)
                           
                        }))
                        
                         alert3.addAction(OkAction)
                         alert2.addAction(OkAction)
                         alert.addAction(cancelAction)
                         present(alert, animated: true, completion: nil)
                        
                
            }
            */
 
    
    func filterContentForSearchText(_ searchText: String, scope: String = "ทั้งหมด") {
        filteredfoods = foods.filter({( food : FoodItem) -> Bool in
            let doesCategoryMatch = (scope == "ทั้งหมด") || (food.price == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
                print("is Empty")
                
            } else {
                 print("not Empty")
                print(food.name)
      
                print(searchText)
                return doesCategoryMatch || food.name.lowercased().contains(searchText.lowercased()) || food.name.contains(searchText) || food.name.contains(searchText.lowercased()) || food.name.lowercased().contains(searchText)

            }
        })        

            self.tableView.reloadData();


    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }

}

extension FoodViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
   
    
}



extension FoodViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension UITableView {
    func hideSearchBar() {
        if let bar = self.tableHeaderView as? UISearchBar {
            let height = bar.frame.height
            let offset = self.contentOffset.y
            if offset < height {
                self.contentOffset = CGPoint(x: 0, y: height)
            }
        }
    }
}
