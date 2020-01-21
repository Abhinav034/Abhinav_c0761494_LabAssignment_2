//
//  UserTasksTVC.swift
//  Abhinav_c0761494_LabAssignment_2
//
//  Created by Abhinav Bhardwaj on 2020-01-19.
//  Copyright © 2020 Abhinav Bhardwaj. All rights reserved.
//

import UIKit
import CoreData

var appDelegate = UIApplication.shared.delegate as? AppDelegate
class UserTasksTVC: UITableViewController  , UIGestureRecognizerDelegate{
    
 
    @IBOutlet weak var sortButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    var taskArray:[Task] = []
    var search:[Task] = []
    var searching = false
    var sorting = false
    
    
    var id:IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fetchData()
        userTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }
    
    func userTapped(){
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(tapsBegin))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        self.tableView.addGestureRecognizer(doubleTap)
    }
    
   @objc func tapsBegin(){
        
    self.tableView.endEditing(true)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            if search.count > 0 {
                 return search.count
            }
           
        }
        
            return taskArray.count
       
        
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! Cell_Controller
        if searching && search.count > 0{
            
             let items = search[indexPath.row]
             cell.cellDisplay(task: items)
             return cell
               }
        else{
                let items = taskArray[indexPath.row]
            id = indexPath
                cell.cellDisplay(task: items)
                return cell
        }
        
       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let taskcompletion = taskArray[indexPath.row].taskCompletionValue
        let taskDescription = taskArray[indexPath.row].taskDescription
        let taskDate = taskArray[indexPath.row].taskDate
       let taskDate1 = taskDate?.replacingOccurrences(of: "/", with: "")
        print(taskDate1 as Any)
    }
    
    
   

   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = editAction(indexPath: indexPath)
        let delete = deleteAction(indexPath: indexPath)
        
         return UISwipeActionsConfiguration(actions: [delete,edit])
    
    }
    
    func editAction(indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Add 1") { (action, view, complete) in
            
            self.progress(indexPath: indexPath)
            self.tableView.reloadData()
        }
        action.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return action
        
    }
    
    func deleteAction(indexPath: IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, complete) in
            
            self.removeTask(indexPath: indexPath)
            self.fetchData()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            complete(true)
        }
        
        return action
        
    }
    
    // MARK: Sort button
    
    
    @IBAction func sortPressed(_ sender: UIButton) {
        
        if sortButton.titleLabel?.text == "Sort"{
                  sorting = true
                  fetchData()
                  tableView.reloadData()
                  sorting = false
            sortButton.setTitle("Unsort", for: .normal)
              }
        
        else if sortButton.titleLabel?.text == "Unsort" {
            
            fetchData()
            tableView.reloadData()
            sortButton.setTitle("Sort", for: .normal)
            
        }
        
        
        
    }
    
    
    
   
    
    
    
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
 
   

  
 
    
}
extension UserTasksTVC {
    
    func fetchData(){
           
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
           
           let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
           
        if sorting == true {
            
            let sort1 = NSSortDescriptor(key: "taskDescription", ascending: true)
                 
                 fetchRequest.sortDescriptors = [sort1]
        }
     
       
        
           do {
               taskArray = try managedContext.fetch(fetchRequest)
               print("fetched successfully")
           } catch  {
               print("Not able to fetch data --------\(error)")
           }
           
       }
    
    func removeTask(indexPath : IndexPath){
        
     guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        if searching{
            managedContext.delete(search[indexPath.row])
            searchBar.text = ""
            searchBar.resignFirstResponder()
            searching = false
            tableView.reloadData()
        }
        else{
        managedContext.delete(taskArray[indexPath.row])
        }
        do {
            
            try managedContext.save()
            print("removed successfully")
        }
            
            catch{
                print(error)
            }
        }
    
    func progress( indexPath:IndexPath){
         guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        
        if searching{
            let add = search[indexPath.row]
        
            if add.taskCompletionValue < add.progress{
                
                add.taskCompletionValue += 1
                
                
            }else{
                return
            }
        
        } else if searching == false {
            let task = taskArray[indexPath.row]
                  
                  if task.taskCompletionValue < task.progress {
                      
                      task.taskCompletionValue += 1
                      
                      
                  }else{
                      return
                  }
        }
        
      
        
        do {
            try managedContext.save()
        } catch  {
            print(error)
        }
        
    }
    
    
}
extension UserTasksTVC : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        search = taskArray.filter({$0.taskDescription!.prefix(searchText.count) == searchText})
        
        searching = true
        
        
        if searchBar.text == "" {
            
            searching = false
            searchBar.resignFirstResponder()
        }
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searching = false
        
        tableView.reloadData()
        
    }
    
    
    
    
    
}
