//
//  TaskVC.swift
//  Abhinav_c0761494_LabAssignment_2
//
//  Created by Abhinav Bhardwaj on 2020-01-19.
//  Copyright © 2020 Abhinav Bhardwaj. All rights reserved.
//

import UIKit
import CoreData
class TaskVC: UIViewController , UITextViewDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var taskProgressField: UITextField!
    
    var editTask = ""
    var editProgress:Int16 = 0
    
    var date: String = ""
    var taskDescription:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        taskTextView.delegate = self
        taskProgressField.delegate = self
        taskProgressField.text = ""
        
        taskTextView.text = editTask
        taskProgressField.text = String(editProgress)
        taskTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
       // taskTextView.text = ""
        taskTextView.becomeFirstResponder()
        taskTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       
    }
    
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        
        taskProgressField.text = ""
        taskProgressField.becomeFirstResponder()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    

    @IBAction func addTaskPressed(_ sender: UIButton) {
        
        if taskProgressField.text != "" && taskTextView.text != "" && taskProgressField.text != "0"{
            
              taskDescription = taskTextView.text!
            saveData()
             navigationController?.popToRootViewController(animated: true)
        }
        else{
           
            let alert = UIAlertController(title: "Empty Fields", message: "Please fill all the fields", preferredStyle: .alert)
             
             alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
         
    }
    
    func currentDate() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let currentDate = Date()
        let dateString = formatter.string(from: currentDate)
        NSLog("%@", dateString)
        return dateString
    }
    

    
    
    func saveData(){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        
        let data = Task(context: managedContext)
        data.taskDescription = taskDescription
        data.taskDate = currentDate().replacingOccurrences(of: "/", with: "")
        data.progress = Int16(taskProgressField.text!)!
        data.taskCompletionValue = Int16(0)
        
        do {
            try managedContext.save()
            print("saved Successfully")
        } catch  {
            print(error)
        }
        
        
        
        
        
    }
    
    
    
    
    
}

