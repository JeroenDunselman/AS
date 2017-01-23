import UIKit
import Firebase
import EventKit
import EventKitUI
private let revealSequeId = "revealSegue"

class CardViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var fillInText: UITextField!
  @IBOutlet fileprivate weak var cardView: UIView!
  @IBOutlet fileprivate weak var titleLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!
  
  @IBOutlet weak var pickerView: UIView!
  var pageIndex: Int?
  var petCard: PetCard?
  var sportsCard: SportsCard?
  
  var defaultText:String = "Vul iets in"
  public var currentMatch:MatchItem?
  var key: String?
  var value:String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fillInText.delegate = self
    fillInText.returnKeyType = UIReturnKeyType.done
    
    getCurrentData()
    
    self.title = sportsCard?.name
    //    titleLabel.layer.cornerRadius = 20?
    titleLabel.text = sportsCard?.description
    detailLabel.text = sportsCard?.name
    prepareCardView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    //    self.fillInText.text = result
  }
  
  func getCurrentData() {
    let myPageViewController = self.parent as! MyNextViewController
    currentMatch = myPageViewController.currentMatch!
    
    if let keyType = self.sportsCard?.matchItemKey  {
      switch (keyType){
      case "sport":
        value = currentMatch!.sport
      case "participants":
        value = currentMatch!.participants
      case "time":
        value = currentMatch!.time
      case "result":
        value = currentMatch!.result
        //      case "image":
      //        value = currentMatch.
      default:
        value = defaultText
      }
    }
    
    self.fillInText.text = value//. //"" //getDbValue() //result
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    
    if let user = FIRAuth.auth()?.currentUser {
      if let itemKey = (self.sportsCard?.matchItemKey)  {
        let refString:String = "/users/\(user.uid)/match-items/\(self.key!)/\(itemKey)"
        let ref = FIRDatabase.database().reference(withPath: refString )
        if let text = fillInText.text {
          ref.setValue(text)
        }
      }
    }
    
    return true;
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
  }
  
  func prepareSportPicker() {
    if let sportPickerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idSportPicker") as? SportPVC {
      
      if let user = FIRAuth.auth()?.currentUser {
        if let itemKey = (self.sportsCard?.matchItemKey)  {
          let refString:String = "/users/\(user.uid)/match-items/\(self.key!)/\(itemKey)"

          sportPickerVC.refString = refString
          sportPickerVC.theSport = value
          sportPickerVC.view.frame = self.pickerView.bounds
          self.addChildViewController(sportPickerVC)
          sportPickerVC.didMove(toParentViewController: self)
          self.pickerView!.addSubview(sportPickerVC.view!)
        }
      }
      
      
    }
  }
  func prepareOpponentPicker(){
    
  }
  func prepareEventPicker() {
    if let user = FIRAuth.auth()?.currentUser {
      if let itemKey = (self.sportsCard?.matchItemKey)  {
//        let refString:String = "/users/\(user.uid)/match-items/\(self.key!)/\(itemKey)"
        
        let eVC = EKEventViewController()
        eVC.view.frame = self.pickerView.bounds
        self.addChildViewController(eVC)
        eVC.didMove(toParentViewController: self)
        self.pickerView!.addSubview(eVC.view!)
       
      }
    }

    
  }
  func prepareResultPicker() {
    
    
    if let pickerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idScorePicker") as? ResultPickerVC {
      
      if let user = FIRAuth.auth()?.currentUser {
        if let itemKey = (self.sportsCard?.matchItemKey)  {
          let refString:String = "/users/\(user.uid)/match-items/\(self.key!)/\(itemKey)"
          
          pickerVC.refString = refString
          pickerVC.theResult = value
          pickerVC.view.frame = self.pickerView.bounds
          self.addChildViewController(pickerVC)
          pickerVC.didMove(toParentViewController: self)
          self.pickerView!.addSubview(pickerVC.view!)
        }
      }
      
      
    }
  }
  
  func prepareCardView(){
    let alsJeVanRondHoudt:CGFloat = 15
    cardView.layer.cornerRadius = alsJeVanRondHoudt//25
    cardView.layer.masksToBounds = true
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    cardView.addGestureRecognizer(tapRecognizer)
    
    //    let myPageViewController = self.parent as! MyNextViewController
    //    myPageViewController.resultText = fillInText.text!
    //    self.key = myPageViewController.matchItemKey
    //    let currentMatch:MatchItem = myPageViewController.currentMatch!
    //    var value:String = result
    if let keyType = self.sportsCard?.matchItemKey  {
      switch (keyType){
      case "sport":
        prepareSportPicker()
      case "participants":
        prepareOpponentPicker()
      case "time":
        prepareEventPicker()
      case "result":
        prepareResultPicker()
      default:
        return
      }
    }
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == revealSequeId, let destinationViewController = segue.destination as? RevealViewController {
      destinationViewController.petCard = petCard
    }
  }
  
  func handleTap() {
    //    performSegue(withIdentifier: revealSequeId, sender: nil)
  }
}

/*
 
 func textFieldDidEndEditing(_ textField: UITextField) {
 //    print("TextField did end editing method called")
 }
 func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
 //    print("TextField should begin editing method called")
 return true;
 }
 func textFieldShouldClear(_ textField: UITextField) -> Bool {
 //    print("TextField should clear method called")
 return true;
 }
 
 func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 //    print("While entering the characters this method gets called")
 return true;
 }
 func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 //    print("TextField should return method called")
 textField.resignFirstResponder();
 return true;
 }
 */
