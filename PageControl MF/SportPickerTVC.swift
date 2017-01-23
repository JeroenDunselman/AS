//
//  SportPickerVC.swift
//  PageControl MF
//
//  Created by Jeroen Dunselman on 06/01/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//

import UIKit
extension SportPickerVC: UITableViewDataSource, UITableViewDelegate {
  // MARK:  UITextFieldDelegate Methods
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {return 1}
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return self.swiftBlogs.count}
  
  internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
    
    let row = indexPath.row
    cell.textLabel?.text = swiftBlogs[row]
    
    return cell
  }
  
  // MARK:  UITableViewDelegate Methods
  
  func goBack(){
    dismiss(animated: true, completion: nil)
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    if let resultController = storyboard!.instantiateViewController(withIdentifier: "Red") as UIViewController? {
      
      resultController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(goBack))
      
      let navController = UINavigationController(rootViewController: resultController)
      
      self.present(navController, animated:true, completion: nil)
    }
    
    let row = indexPath.row
    print(self.swiftBlogs[row])
  }
}

class SportPickerVC: UIViewController {
  
  let swiftBlogs = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]
  let textCellIdentifier = "sportPickerCell"

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.register(EventCell.self, forCellReuseIdentifier: textCellIdentifier)
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
