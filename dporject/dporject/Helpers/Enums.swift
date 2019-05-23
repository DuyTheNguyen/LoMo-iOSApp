//
//  Icons.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 16/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import UIKit
//Case-less enum
enum Icons{
    static let USER_MALE =  #imageLiteral(resourceName: "icons8-user_male_circle")
    static let EDIT_ADD = #imageLiteral(resourceName: "icons8-edit_file")
    static let ADD = #imageLiteral(resourceName: "icons8-plus")
    static let ID = #imageLiteral(resourceName: "icons8-identity_theft")
    static let EMAIL = #imageLiteral(resourceName: "icons8-email")
    static let PASSWORD = #imageLiteral(resourceName: "icons8-lock_portrait")
    static let SIGN_OUT = #imageLiteral(resourceName: "icons8-exit")
    static let HOME = #imageLiteral(resourceName: "icons8-a_home")
    static let GENRE = #imageLiteral(resourceName: "icons8-windows_phone_store")
    static let PROFILE = #imageLiteral(resourceName: "icons8-parse_resumes")
    static let SEARCH = #imageLiteral(resourceName: "icons8-search")
    static let EDIT = #imageLiteral(resourceName: "icons8-multi_edit")
    static let HAPPY_FACE = #imageLiteral(resourceName: "icons8-lol")
    static let SAD_FACE = #imageLiteral(resourceName: "icons8-sad")
    static let SAVE = #imageLiteral(resourceName: "icons8-save")
    static let CANCEL = #imageLiteral(resourceName: "icons8-delete_sign")
    static let NAME = #imageLiteral(resourceName: "icons8-employee_card")
    static let FAILED = #imageLiteral(resourceName: "icons8-cancel")
    static let SUCCESS = #imageLiteral(resourceName: "icons8-ok")
    static let WARNING = #imageLiteral(resourceName: "icons8-attention")
}

enum UserService{
    case SIGN_IN, SIGN_UP, SIGN_OUT
}

enum AlertType{
    case SUCCESS, FALIED, INFO
}

enum CustomColors{
    static let GREEN = UIColor.init(red: 76/255, green: 175/255, blue: 80/255, alpha: 1.0)
    static let RED =  UIColor.init(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0)
    static let YELLOW = UIColor.init(red: 247/255, green: 204/255, blue: 80/255, alpha: 1.0)
}


enum ViewTags{
    static let PROFILE_VIEW = 88888
    static let INDICATOR_VIEW  = 77777
}

enum AlertMessages{
    static let FAILED_EMPTY_ENAIL_PASSWORD_CPASSWORD = ""
    static let FAILED_EMPTY_EMAIL_PASSWORD = "Email and Password could not be empty!"
    static let FAILED_EMPTY_STRING = ""
    static let FAILED_VALID_EMAIL = ""
    
    static let INFO_NOT_IMPLEMENTED = "This function has not been implemented yet!"
}

