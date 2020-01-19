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
    
    
    var goalProgress:Int32?
    
    
    func cellDisplay(task: Task ){
        
        self.descriptionLbl.text = task.taskDescription
        self.dateLbl.text = task.taskDate
        self.goalProgress = task.progress
        
        
        
        
        
    }
    
    
    
  

  

}
