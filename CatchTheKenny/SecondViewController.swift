//
//  SecondViewController.swift
//  CatchTheKenny
//
//  Created by Kemal Özyön on 15.08.2024.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var FinisedImageView: UIImageView!
    @IBOutlet weak var finisedUserNameLabel: UILabel!
    @IBOutlet weak var finishedUserScoreLabel: UILabel!
    @IBOutlet weak var finisedTimeLabel: UILabel!
    @IBOutlet weak var saveTheScoreButtonUI: UIButton!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var designLabel2: UILabel!
    @IBOutlet weak var DesignLabel: UILabel!
    
    
    var timer : Timer?
    var myTime : Int?
    var userName : String?
    var score = 0
    var savingTime : Int!
    var id : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if id != nil{
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
            timeLabel.isHidden = true
            scoreLabel.isHidden = true
            
            
            FinisedImageView.isHidden = false
            finisedUserNameLabel.isHidden = false
            finishedUserScoreLabel.isHidden = false
            finisedTimeLabel.isHidden = false
            saveTheScoreButtonUI.isHidden = true
            goBackButton.isHidden = false
            designLabel2.isHidden = false
            DesignLabel.isHidden = false
            
            FinisedImageView.image = UIImage(named: "Kenny.png")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let idString = id?.uuidString
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
            fetchRequest.predicate = NSPredicate(format: "id == %@", idString!)
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0{
                    for result in results as! [NSManagedObject]{
                        if let name = result.value(forKey: "name") as? String{
                            if let score = result.value(forKey: "score") as? Int32{
                                if let time = result.value(forKey: "time") as? Int32{
                                    finisedTimeLabel.text = String(time)
                                    finisedUserNameLabel.text = String(name)
                                    finishedUserScoreLabel.text = String(score)
                                }
                            }
                        }
                    }
                }
            }catch{
                print("error")
            }

            
        }else{
            savingTime = myTime!
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
            FinisedImageView.isHidden = true
            finisedUserNameLabel.isHidden = true
            finishedUserScoreLabel.isHidden = true
            finisedTimeLabel.isHidden = true
            saveTheScoreButtonUI.isHidden = true
            goBackButton.isHidden = true
            designLabel2.isHidden = true
            DesignLabel.isHidden = true
            
            //When the game open, hide all kennies.
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
            
            //making all kennies clickable and understand which kenny was cliked
            kenny1.isUserInteractionEnabled = true
            kenny2.isUserInteractionEnabled = true
            kenny3.isUserInteractionEnabled = true
            kenny4.isUserInteractionEnabled = true
            kenny5.isUserInteractionEnabled = true
            kenny6.isUserInteractionEnabled = true
            kenny7.isUserInteractionEnabled = true
            kenny8.isUserInteractionEnabled = true
            kenny9.isUserInteractionEnabled = true
            let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            kenny1.addGestureRecognizer(gestureRecognizer1)
            kenny2.addGestureRecognizer(gestureRecognizer2)
            kenny3.addGestureRecognizer(gestureRecognizer3)
            kenny4.addGestureRecognizer(gestureRecognizer4)
            kenny5.addGestureRecognizer(gestureRecognizer5)
            kenny6.addGestureRecognizer(gestureRecognizer6)
            kenny7.addGestureRecognizer(gestureRecognizer7)
            kenny8.addGestureRecognizer(gestureRecognizer8)
            kenny9.addGestureRecognizer(gestureRecognizer9)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    @objc func countDown(){
        let randomInt = Int.random(in: 1 ... 9)
        switch randomInt{
        case 1:
            kenny1.isHidden = false
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 2:
            kenny1.isHidden = true
            kenny2.isHidden = false
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 3:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = false
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 4:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = false
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 5:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = false
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 6:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = false
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 7:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = false
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 8:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = false
            kenny9.isHidden = true
        case 9:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = false
        default:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        }
        if(myTime! >= 0){
            timeLabel.text = "Time: \(myTime!)"
            myTime! -= 1
        }
        else{
            timer?.invalidate()
            timer = nil
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
            timeLabel.isHidden = true
            scoreLabel.isHidden = true
            
            
            FinisedImageView.isHidden = false
            finisedUserNameLabel.isHidden = false
            finishedUserScoreLabel.isHidden = false
            finisedTimeLabel.isHidden = false
            saveTheScoreButtonUI.isHidden = false
            goBackButton.isHidden = false
            designLabel2.isHidden = false
            DesignLabel.isHidden = false
            
            FinisedImageView.image = UIImage(named: "Kenny.png")
            finisedUserNameLabel.text = "User Name: \(userName!)"
            finishedUserScoreLabel.text = "User Score: \(score)"
            finisedTimeLabel.text = ("User Time: \(self.savingTime!)")
        }
    }
    @objc func increaseScore(){
        //Increase The Score and print it to screen
        score = score + 1
        print(score)
        scoreLabel.text = "Score: \(score)"
        // Show kenny on another place after clicking
        let randomInt = Int.random(in: 1 ... 9)
        switch randomInt{
        case 1:
            kenny1.isHidden = false
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 2:
            kenny1.isHidden = true
            kenny2.isHidden = false
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 3:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = false
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 4:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = false
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 5:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = false
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 6:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = false
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 7:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = false
            kenny8.isHidden = true
            kenny9.isHidden = true
        case 8:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = false
            kenny9.isHidden = true
        case 9:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = false
        default:
            kenny1.isHidden = true
            kenny2.isHidden = true
            kenny3.isHidden = true
            kenny4.isHidden = true
            kenny5.isHidden = true
            kenny6.isHidden = true
            kenny7.isHidden = true
            kenny8.isHidden = true
            kenny9.isHidden = true
        }
        
    }
    @IBAction func saveTheDatas(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newData = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context)
        newData.setValue(userName, forKey: "name")
        newData.setValue(UUID(), forKey: "id")
        newData.setValue(score, forKey: "score")
        newData.setValue(savingTime, forKey: "time")
        
        do{
            try context.save()
            print("success")
            
        }catch{
            print("Error")
        }
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goBackWithoutSaving(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
