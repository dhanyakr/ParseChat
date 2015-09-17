//
//  ChatViewController.m
//  ParseChat
//
//  Created by Dhanya R on 9/16/15.
//  Copyright © 2015 Dhanya R. All rights reserved.
//

#import "ChatViewController.h"
#import "MsgTableViewCell.h"

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, retain) NSArray *infoArray;
- (void)onTimer;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"chatting");
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector: @selector(onTimer) userInfo:nil repeats:YES];
    [self onTimer];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendButton:(id)sender {
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"text"] = self.msgTextField.text;
    message[@"user"] = [PFUser currentUser];
    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"successfully submitted the msg: %@", message);
        } else {
            // There was a problem, check error.description
            NSLog(@"failed submitting the msg");
        }
    }];
}

- (void)onTimer{
    NSLog(@"Timer running ");
    PFQuery *query = [PFQuery queryWithClassName:@"Message"];
    
    // Retrieve the most recent ones
    [query orderByDescending:@"createdAt"];
    
    // Only retrieve the last ten
    //query.limit = 30;
    
    // Include the post data with each comment
    // [query includeKey:@"post"];
    [query includeKey:@"createdBy"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu messages.", objects.count);
            self.infoArray = objects;
            // Do something with the found objects
            /*
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                NSLog(@"%@", object[@"text"]);
                NSLog(@"%@", object[@"user"]);
            }
             */
            [self.myTableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark - Table view methods

- (long)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"response count : %lu", self.infoArray.count);
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myTableViewCell"];

    PFObject *object = self.infoArray[indexPath.row];
    PFUser *user = [object objectForKey:@"user"];
    [user fetchIfNeeded];
    
    // NSLog(@"This is a user %@", user);
    //NSString *username = [user objectForKey:@"username"];
    // NSLog(@"This is username %@", username);
    
    cell.msgLabel.text = object[@"text"];
    cell.userLabel.text = [NSString stringWithFormat:@"< %@",user[@"username"]];
    
    return cell;
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
