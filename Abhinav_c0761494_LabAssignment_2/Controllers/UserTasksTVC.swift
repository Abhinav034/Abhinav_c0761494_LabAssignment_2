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
class UserTasksTVC: UITableViewController {
    
    
    var taskArray:[Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return taskArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! Cell_Controller

        cell.descriptionLbl.text = taskArray[indexPath.row].taskDescription
        cell.dateLbl.text = taskArray[indexPath.row].taskDate
        cell.daysLbl.text = "0"
        cell.goalProgress = taskArray[indexPath.row].progress
        return cell
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
    
    
    
    
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
 
    
}
extension UserTasksTVC {
    
    func fetchData(){
           
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
           
           let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
           
           do {
               taskArray = try managedContext.fetch(fetchRequest)
               print("fetched successfully")
           } catch  {
               print("Not able to fetch data --------\(error)")
           }
           
       }
    
    func removeTask(indexPath : IndexPath){
        
     guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        
        managedContext.delete(taskArray[indexPath.row])
        
        do {
            
            try managedContext.save()
            print("removed successfully")
        }
            
            catch{
                print(error)
            }
    
        
        
        
    }
    
    
    
    
}
