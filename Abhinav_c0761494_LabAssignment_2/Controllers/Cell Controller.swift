//
//  Cell Controller.swift
//  Abhinav_c0761494_LabAssignment_2
//
//  Created by Abhinav Bhardwaj on 2020-01-19.
//  Copyright © 2020 Abhinav Bhardwaj. All rights reserved.
//

import UIKit

class Cell_Controller: UITableViewCell {

    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    @IBOutlet weak var dateLbl: UILabel!
    
    
    @IBOutlet weak var daysLbl: UILabel!
    
    
    @IBOutlet weak var completeView: UIView!
    
   
    
    

    
    
    func cellDisplay(task: Task ){
        
        self.descriptionLbl.text = task.taskDescription
        
        let date =  task.taskDate?.prefix(2)
        let year = task.taskDate?.suffix(4)
        
        let substr = task.taskDate?.prefix(4)
        let month = substr?.suffix(2)
        
        
        self.dateLbl.text = "\(date!)/\(month!)/\(year!) "
        self.daysLbl.text = String(task.taskCompletionValue)
      
        
        if task.progress == task.taskCompletionValue {
            
            completeView.isHidden = false
           
        }else{
            
            self.completeView.isHidden = true
        }
         
        
        
        
    }
    
    
    
  

  

}
