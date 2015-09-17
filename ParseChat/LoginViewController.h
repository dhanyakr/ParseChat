//
//  LoginViewController.h
//  ParseChat
//
//  Created by Dhanya R on 9/16/15.
//  Copyright © 2015 Dhanya R. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
// @property (nonatomic,strong) NSDictionary *infoDictionary;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end
