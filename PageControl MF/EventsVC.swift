//
//  EventsVC.swift
//  PageControl MF
//
//  Created by Jeroen Dunselman on 05/01/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//
import UIKit

class EventsVC: UIViewController {
  
  public var eventCards = SportsCardStore.eventCards()
  var eventsTVC: EventsTVC?
  
  @IBOutlet weak var tableView: UITableView!
  //oranje met plusbutton
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    if let eventsTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idEventsTVC") as? EventsTVC {
      //      eventsTVC.tableView.dataSource = self
      //      eventsTVC.tableView.delegate = self
      //            eventsTVC.tableView.register(EventCell.self, forCellReuseIdentifier: "idEventCell")
      self.eventCards = SportsCardStore.eventCards()
      self.tableView.addSubview(eventsTVC.view)
    }
  }
  override func viewDidAppear(_ animated: Bool) {
    eventsTVC?.tableView.reloadData()
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
//extension EventsVC: UITableViewDataSource, UITableViewDelegate{
//   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    // #warning Incomplete implementation, return the number of rows
//    return self.eventCards.count
//  }
//
//   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    
//    let cell:EventCell =
//      eventsTVC!.tableView!.dequeueReusableCell(withIdentifier: "idEventCell") as! EventCell
//    cell.backgroundColor = UIColor.blue
//    cell.textLabel?.backgroundColor = UIColor.black
//    cell.textLabel?.textColor = UIColor.white
//    let theCard = eventCards[indexPath.row] //"Configure the cell..."
//    
//    cell.textLabel?.text = theCard.name
//    return cell
//  }
//  
//  //   PizzaMenuTableViewController class:
//   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    //   let row = indexPath.row
//    //   let section = indexPath.section
//    //
//    //    let event = myEvents.items[section][row]
//    //   let order = menuItems.items[section][row]
//    
//    //    event.name += " " + myEvents.sections[section]
//    //   order.name += " " + menuItems.sections[section]
//    navigationItem.title = "HatscheFladscg" //order.name
//    if let resultController = storyboard!.instantiateViewController(withIdentifier: "Purple") as UIViewController? {
//      
//      resultController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.goBack))
//      
//      let navController = UINavigationController(rootViewController: resultController)
//      
//      self.present(navController, animated:true, completion: nil)
//    }
//    
//  }
//  
//  func goBack(){
//    dismiss(animated: true, completion: nil)
//  }
//
//}


