//
//  Task.swift
//  MjeedTo-Do-LIst
//
//  Created by Abdullmajeed Alamri on 09/11/2020.
//

import UIKit

struct Task : Equatable, Codable {
    var taskTitle : String
    let dueDate : Date?
    let createdDate: Date
    var additionalInfo: String
    var isCompleted : Bool
}
