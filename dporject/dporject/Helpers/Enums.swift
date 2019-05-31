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

enum ObserveType{
    case COMMENT, RATING
}

enum CustomColors{
    static let MAIN = UIColor.init(red: 64/255, green: 96/255, blue: 160/255, alpha: 1.0)
    static let GREEN = UIColor.init(red: 76/255, green: 175/255, blue: 80/255, alpha: 1.0)
    static let RED =  UIColor.init(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0)
    static let YELLOW = UIColor.init(red: 247/255, green: 204/255, blue: 80/255, alpha: 1.0)
}


enum ViewTags{
    static let PROFILE_VIEW = 88888
    static let INDICATOR_VIEW  = 77777
}

enum AlertMessages{
    //Failed
    static let FAILED_EMPTY_ENAIL_PASSWORD_CPASSWORD = "Email, Password and Confirm Password could not be empty!"
    static let FAILED_EMPTY_EMAIL_PASSWORD = "Email and Password could not be empty!"
    static let FAILED_DIFFERENT_PASSWORD_CPASSWORD = "Password and Confirm Password must be the same!"
    static let FAILED_EMPTY_STRING = "New value could not be empty!"
    static let FAILED_INVALID_EMAIL = "Please enter a valid email \n Ex: abc@gmail.com"
    
    //Success
    static let SUCCESS_UPDATE_EMAIL = "Update Email Successfully"
    static let SUCCESS_UPDATE_NAME = "Update Name Successfully"
    static let SUCCESS_UPDATE_PASSWORD = "Update Password Successfully"
    static let SUCCESS_UPDATE_IMAGE = "Update Image Successfully"
    
    static let SUCCESS_SIGNIN = "Sign In Successfully"
    static let SUCCESS_SIGNUP = "Sign Up Successfully"
    
    //Info
    static let INFO_NOT_IMPLEMENTED = "This function has not been implemented yet!"
}


enum AlertTitles{
    static let SUCCESS = "Yayy!! You did it!!"
    static let FAILED = "Opps!! Something went wrong"
    static let INFO = "Sorry!!!"
}

enum DataType{
    case Movie, Genre, Cinema
}


enum Identifiers{
    //Others
    static let TAB_BAR_CONTROLLER = "TabBarController"
    static let SIGN_IN_CONTROLLER = "SignInViewController"
    
    //Cells
    static let HOT_MOVIES_CELL = "HotMoviesCell"
    static let COMMENT_CELL = "CommentCell"
    static let GENRE_CELL = "GenreCell"
    static let MOVIE_CELL = "MovieCell"
    
    //Navigations
    static let HOME_TO_MOVIE = "homeToMovie"
    
    static let SIGNUP_TO_ALERTMODAL = "signUpToAlertModal"
    static let SIGNUP_TO_SIGNIN = "signUpToSignIn"
    
    static let SIGNIN_TO_ALERTMODAL = "signInToAlertModal"
    static let SIGNIN_TO_SIGNUP =  "signInToSignUp"
    
    static let MOVIE_TO_COMMENTMODAL = "movieToComment"
    static let MOVIE_TO_RATINGMODAL = "movieToRating"
    
    static let GENRE_TO_MOVIELIST = "genreToMovieList"
    
    static let UPDATEMODAL_TO_ALERTMODAL = "updateModalToAlertModal"
    
    static let PROFILE_TO_ALERTMODAL = "profileToAlert"
    static let PROFILE_TO_UPDATEMODAL = "profileToUpdate"
    
    static let MOVIELIST_TO_MOVIE = "movieListToMovie"
}

enum Notifications{
    static let CLOSE_UPDATE_MODAL = "CloseUpdateModalNoti"
    static let TO_SIGN_IN = "ToSignInNoti"
}

enum Paths{
    static let POPULAR_MOVIES = "popular"
    static let COMMENTS = "comments"
    static let RATING = "ratings"
    static let CINEMAS = "cinemas"
    static let GENRE = "genre"
    static let GENRE_MOVIES_LIST = "genremovies"
}

enum GeneralMessages{
    static let EMPTY_LIST_OF_COMMENTS = "There are no comments!"
    static let EMPTY_LIST_OF_RESULT_MOVIES = "404!!! Not found any movies!!!"
}
