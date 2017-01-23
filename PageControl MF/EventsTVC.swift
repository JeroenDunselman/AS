//
//  EventsTVC.swift
//  PageControl MF
//
//  Created by Jeroen Dunselman on 05/01/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//

import UIKit
extension EventsTVC {
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return eventCards.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell:EventCell = self.tableView.dequeueReusableCell(withIdentifier: "idEventCell") as! EventCell
    cell.backgroundColor = UIColor.blue
    cell.textLabel?.backgroundColor = UIColor.black
    cell.textLabel?.textColor = UIColor.white
    let theCard = eventCards[indexPath.row]
    cell.titleLabel!.text = theCard.description
    cell.textLabel?.text = theCard.name
    cell.detailTextLabel?.text = theCard.description
    return cell
  }
  
  // PizzaMenuTableViewController class:
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //   let row = indexPath.row
    //   let section = indexPath.section
    //
    //    let event = myEvents.items[section][row]
    //   let order = menuItems.items[section][row]
    
    //    event.name += " " + myEvents.sections[section]
    //   order.name += " " + menuItems.sections[section]
    theCard = self.eventCards[indexPath.row]
    if let resultController = storyboard!.instantiateViewController(withIdentifier: "Purple") as UIViewController? {
      resultController.navigationItem.title = theCard?.name //order.name
      resultController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.goBack))
      
      let navController = UINavigationController(rootViewController: resultController)
      //      self.present(navController, animated:true, completion: nil)
      
      let transition = CATransition()
      transition.duration = 0.2
      transition.type = kCATransitionPush
      transition.subtype = kCATransitionFromRight
      view.window!.layer.add(transition, forKey: kCATransition)
      
      present(navController, animated: false, completion: nil)
      
      //      let animation = CATransition()
      //      animation.duration = 0.5
      //      animation.type = kCATransitionPush
      //      animation.subtype = kCATransitionFromRight
      //      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      //      navController.view.layer.add(animation, forKey: "SwitchToView")
      
      
      //      self.showDetailViewController(navController, sender: self)
      //      self.addChildViewController(navController)
    }
    
  }
  
  func goBack(){
    dismiss(animated: true, completion: nil)
  }
  
}

class EventsTVC: UITableViewController {
  public var eventCards = SportsCardStore.eventCards()
  public var theCard:SportsCard?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    theCard = eventCards[0]
    //      [self.tableView setContentInset:UIEdgeInsetsMake(50,0,0,0)]
    self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0  , right: 0)
    
    tableView.register(EventCell.self, forCellReuseIdentifier: "idEventCell")
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
/**/

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


