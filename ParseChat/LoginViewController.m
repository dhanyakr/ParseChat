//
//  LoginViewController.m
//  ParseChat
//
//  Created by Dhanya R on 9/16/15.
//  Copyright © 2015 Dhanya R. All rights reserved.
//

#import "LoginViewController.h"
#import "ChatViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)signInAction:(id)sender {
    NSLog(@"Signin");

    [PFUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text
        block:^(PFUser *user, NSError *error) {
            NSLog(@"user %@", user);
            if (user) {
                // Do stuff after successful login.
                NSLog(@"logged in");
                [self performSegueWithIdentifier:@"com.dhanyakr.chatViewController" sender:self];
                
            } else {
                // The login failed. Check error to see why.
                NSLog(@"logged in failed");
                self.errorLabel.text = @"Login failed!";
            }
    }];
}
- (IBAction)signUpAction:(id)sender {
    NSLog(@"Signup");
    PFUser *user = [PFUser user];
    user.username = self.usernameTextField.text;
    user.password = self.passwordTextField.text;
    //user.email = @"dkr1@dkr.com";
    
    // other fields can be set just like with PFObject
    user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            NSLog(@"success");
            [self performSegueWithIdentifier:@"com.dhanyakr.chatViewController" sender:self];
        } else {
            NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            NSLog(@"error : %@", errorString);
            self.errorLabel.text = errorString;
            
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.infoDictionary = [NSDictionary dictionaryWithObjects:<#(nonnull NSArray *)#> forKeys:<#(nonnull NSArray<id<NSCopying>> *)#>]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
