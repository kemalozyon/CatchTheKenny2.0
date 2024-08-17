//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Kemal Özyön on 15.08.2024.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var TimeInteger: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var idArray = [UUID]()
    var transportID : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getData()
        // Do any additional setup after loading the view.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TimeInteger.text = ""
        userName.text = ""
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    @objc func getData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let requests = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        requests.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(requests)
            
            if results.count > 0{
                self.nameArray.removeAll(keepingCapacity: false)
                self.idArray.removeAll(keepingCapacity: false)
                for result in results as! [NSManagedObject]{
                    if let user = result.value(forKey: "name") as? String{
                        self.nameArray.append(user)
                    }
                    if let id = result.value(forKey: "id") as? UUID{
                        self.idArray.append(id)
                    }
                }
                tableView.reloadData()
            }
        }catch{
            print("Error")
        }
    }

    @IBAction func playGame(_ sender: Any) {
        if Int(TimeInteger.text!) != nil{
            if userName.text! != ""{
                performSegue(withIdentifier: "goToGame", sender: nil)
            }
            else{
                makingAlert(title: "Error", message: "UserName cannot be left empty!")
            }
        }
        else{
            makingAlert(title: "Error", message: "Time needs to be an Integer.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame"{
            let destinatonVC = segue.destination as! SecondViewController
            destinatonVC.myTime = Int(TimeInteger.text!)
            destinatonVC.userName = userName.text!
        }
        if segue.identifier == "goToDetails"{
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.id = transportID
        }
    }
    
    
    
    func makingAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = nameArray[indexPath.row]
        content.textProperties.color = .white
        cell.backgroundColor = .black
        cell.contentConfiguration = content
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transportID = idArray[indexPath.row]
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let itemToDelete = idArray[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0{
                    for result in results as! [NSManagedObject]{
                        if let id = result.value(forKey: "id") as? UUID{
                            if id == idArray[indexPath.row]{
                                context.delete(result)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                do{
                                    try context.save()
                                }
                                catch{
                                    print("Error")
                                }
                                break
                            }
                        }
                    }
                }
            }catch{
                print("error")
            }
            
        }
    }
}

